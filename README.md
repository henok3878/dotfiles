# dotfiles

This repo contains all my personalized configuration and helper scripts for a complete macOS development environment.

## Structure

- **`home/`** - Dotfiles that live in `$HOME` (e.g: `.zshrc`)
- **`configs/`** - [XDG-style](https://specifications.freedesktop.org/basedir-spec/latest/) config directories under `~/.config/` (e.g: `nvim/`, `ghostty/`)
- **`scripts/`** - Executable utilities which get symlinked to `~/scripts/`
- **`Brewfile`** - Homebrew bundle file with all packages, casks, and VS Code extensions
- **`install.sh`** - Automated setup script that installs everything

## Quick Setup (Fresh Mac)

On a brand new Mac, simply run:

```bash
# Install Command Line Tools (required for git)
xcode-select --install

# Clone the dotfiles repo
git clone https://github.com/henok3878/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the full installation
./install.sh
```

This will automatically:

- ✅ Install Homebrew
- ✅ Install all packages from Brewfile (including Ghostty, Tmux, Neovim, etc.)
- ✅ Set up Oh My Zsh with Powerlevel10k theme
- ✅ Install zsh plugins (syntax highlighting, autosuggestions)
- ✅ Configure Python environment with pyenv
- ✅ Set up fzf with key bindings
- ✅ Create symlinks for all config files
- ✅ Set zsh as default shell
- ✅ Make scripts executable

## Partial Installation

If you only want to update symlinks (e.g., after adding new configs):

```bash
./install.sh --links
```

## What Gets Installed

### Development Tools

- **Homebrew** - Package manager
- **Git** tools (lazygit)
- **Terminal**: Ghostty (modern GPU-accelerated terminal)
- **Editor**: Neovim with custom configuration
- **Shell**: zsh with Oh My Zsh + Powerlevel10k theme
- **Python**: pyenv for version management
- **Node.js** ecosystem
- **Java** (OpenJDK 17 & 23)
- **Go** development tools

### CLI Utilities

- `bat` (better cat)
- `eza` (better ls)
- `fzf` (fuzzy finder)
- `ripgrep` (better grep)
- `zoxide` (better cd)
- `tmux` (terminal multiplexer)
- And many more (see Brewfile)

### Applications

- **Ghostty** - Modern terminal
- **Obsidian** - Note-taking
- **Hammerspoon** - macOS automation

### VS Code Extensions

- GitHub Copilot
- Language support (Python, Go, Dart/Flutter, C/C++, Java)
- Themes and productivity extensions