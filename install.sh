#!/usr/bin/env bash
#
# install.sh: Complete dotfiles setup script for macOS using GNU Stow
#
# Usage:
#   ./install.sh           # Full installation
#   ./install.sh --links   # Only create symlinks using stow
#

set -euo pipefail

# Colors and logging
RED='\033[0;31m'; GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check macOS
[[ "$OSTYPE" != "darwin"* ]] && { log_error "macOS only"; exit 1; }

# Parse arguments
LINKS_ONLY=false
[[ "${1:-}" == "--links" ]] && LINKS_ONLY=true

# Setup variables
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd -P)"
log_info "Dotfiles: $DOTFILES_DIR"

# Utility functions
command_exists() { command -v "$1" >/dev/null 2>&1; }

# Install Homebrew
install_homebrew() {
    command_exists brew && return
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    [[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    log_success "Homebrew installed"
}

# Install packages from Brewfile
install_packages() {
    [[ ! -f "$DOTFILES_DIR/Brewfile" ]] && return
    log_info "Installing packages from Brewfile..."
    cd "$DOTFILES_DIR" && brew bundle install --verbose
    log_success "Packages installed"
}

# Setup Oh My Zsh and plugins
setup_oh_my_zsh() {
    local omz_dir="$HOME/.oh-my-zsh"
    local custom_dir="$omz_dir/custom"
    
    # Install Oh My Zsh
    [[ ! -d "$omz_dir" ]] && {
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    }
    
    # Install theme and plugins
    [[ ! -d "$custom_dir/themes/powerlevel10k" ]] && 
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$custom_dir/themes/powerlevel10k"
    
    [[ ! -d "$custom_dir/plugins/zsh-syntax-highlighting" ]] &&
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting"
    
    [[ ! -d "$custom_dir/plugins/zsh-autosuggestions" ]] &&
        git clone https://github.com/zsh-users/zsh-autosuggestions "$custom_dir/plugins/zsh-autosuggestions"
    
    log_success "Oh My Zsh setup complete"
}

# Setup Python and fzf
setup_extras() {
    # Python
    if command_exists pyenv; then
        local python_version="3.12.7"
        pyenv versions --bare | grep -q "^${python_version}$" || pyenv install "$python_version"
        pyenv global "$python_version"
        log_success "Python $python_version configured"
    fi
    
    # fzf
    if command_exists fzf; then
        local fzf_install="/opt/homebrew/opt/fzf/install"
        [[ -f "$fzf_install" ]] && "$fzf_install" --key-bindings --completion --no-update-rc
        log_success "fzf configured"
    fi
}

# Create symlinks using GNU Stow, backing up only conflicting files
create_symlinks() {
    log_info "Creating symlinks using GNU Stow..."
    command_exists stow || { log_error "GNU Stow not installed. Run: brew install stow"; exit 1; }
    
    cd "$DOTFILES_DIR" || exit 1
    
    local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"
    local backup_created=false
    
    # Backs up a single conflicting file or directory
    backup_item() {
        local target_path="$1"
        if [[ -e "$target_path" && ! -L "$target_path" ]]; then
            if ! $backup_created; then
                mkdir -p "$backup_dir"
                backup_created=true
                log_info "Created backup directory: $backup_dir"
            fi
            log_info "Backing up existing '$target_path'"
            mv "$target_path" "$backup_dir/"
        fi
    }

    # --- Stow packages into ~/.config --- #
    log_info "Processing 'configs' directory..."
    if [[ -d "configs" ]]; then
        # Clean up any problematic absolute symlinks in source directories
        find "configs" -type l | while read -r symlink; do
            if [[ "$(readlink "$symlink")" = /* ]]; then
                log_info "Removing problematic absolute symlink: $symlink"
                rm "$symlink"
            fi
        done
        
        # For each item in configs (nvim, yabai, etc.), check for a conflict
        while IFS= read -r -d '' item; do
            local name
            name=$(basename "$item")
            backup_item "$HOME/.config/$name"
        done < <(find "configs" -mindepth 1 -maxdepth 1 -print0)
        # Now, cd into configs and stow all its contents into ~/.config
        (cd configs && stow --target="$HOME/.config" --restow --adopt *)
        log_success "'configs' directory stowed into ~/.config"
    fi

    # --- Stow packages into ~ --- #
    log_info "Processing 'home' and 'scripts' directories..."
    for dir in home scripts; do
        if [[ -d "$dir" ]]; then
            # For each item in the dir, check for a conflict in the home directory
            while IFS= read -r -d '' item; do
                local name
                name=$(basename "$item")
                backup_item "$HOME/$name"
            done < <(find "$dir" -mindepth 1 -maxdepth 1 -print0)
            # Now, stow the entire package (e.g., 'home') into ~
            stow --target="$HOME" --restow --adopt "$dir"
            log_success "'$dir' package stowed into ~"
        fi
    done
    
    # Make scripts executable after they are linked
    if [[ -d "$HOME/scripts" ]]; then
        find "$HOME/scripts" -type f \( -name "*.sh" -o -name "*.zsh" \) -exec chmod +x {} \;
        log_success "Made scripts executable"
    fi
    
    $backup_created && log_info "Original files backed up to: $backup_dir"
}

# Set zsh as default shell
set_shell() {
    [[ "$SHELL" == *"zsh"* ]] && return
    local zsh_path="$(which zsh)"
    grep -q "$zsh_path" /etc/shells || echo "$zsh_path" | sudo tee -a /etc/shells
    chsh -s "$zsh_path"
    log_success "Default shell set to zsh"
}

# Main installation flow
main() {
    log_info "Starting dotfiles installation..."
    
    if [[ "$LINKS_ONLY" == "false" ]]; then
        install_homebrew
        install_packages
        setup_oh_my_zsh
        setup_extras
        set_shell
    fi
    
    create_symlinks
    
    log_success "Dotfiles installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Restart terminal or: source ~/.zshrc"
    echo "  2. Open Ghostty terminal"
    [[ "$LINKS_ONLY" == "false" ]] && echo "  3. Optional: p10k configure"
}

main "$@"
