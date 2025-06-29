eval "$(zoxide init --cmd cd zsh)"

# bookmark the iCloud Docs folder as ~cloud
hash -d cloud="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# --- Oh My Zsh Setup ---
export ZSH="$HOME/.oh-my-zsh"
# Set theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"
# Enable plugins: git and zsh-syntax-highlighting are already great;
# adding zsh-autosuggestions for command completion suggestions.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"

# --- Powerlevel10k Instant Prompt ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey '^E' autosuggest-accept

# Load Powerlevel10k configuration if available.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Custom Aliases ---

# Editor & compiler 
alias g++="g++-14"
alias vim="nvim"

# CP (Competitive Programming) aliases
source "$HOME/cp/scripts/aliases.zsh"

# fzf + bat preview in Neovim 
# fzf command for opening multiple files in Neovim with a bat powred preview 
alias nfzf='nvim $(fzf -m --preview="bat --color=always {}")'

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
fi 

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --color=auto'
  alias la='eza -alh'
  alias ll='eza -lH'
  alias tree='eza --tree'
fi

# Shortcut for Obsidian symlink script
alias obslink="~/scripts/obsidian_link.zsh"

# git alias 
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gdiff='git diff'
alias gp='git push'
alias gpo='git push origin'
alias gs='git status'
alias gt='git tag'
alias gr='git restore'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# gac: git add + commit in one go
gac() {
  if [ $# -lt 2 ]; then
    echo "Usage: gac <file> \"commit message\""
    return 1
  fi
  git add "$1" && git commit -m "$2"
}

# tmux alias 
alias ta='tmux attach -t'
alias tls='tmux ls' 
alias tks='tmux kill-session -t'
 
brave() {
  open -a "Brave Browser" "$@"
}

#obs: open any folder as an Obsidian valut 
obs(){
  if [[ $# -lt 1 ]]; then 
    echo "Usage: obs <vault-dir-or-path>"
    return 1 
  fi 
  local dir="$1"
  if [[ "$dir" != /* && "$dir" != ~* ]]; then 
    dir="$HOME/$dir"
  fi 

  dir="${dir/#\~/$HOME}"

  open -a Obsidian "$dir"
}

alias dkb='open -a Obsidian ~/dev-knowledge-base'

# --- Environment Variables & PATH Setup ---
# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# --- Pyenv Setup ---
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# OpenSSL (Homebrew): necessary for building some packages.
export LDFLAGS="-L$(brew --prefix)/opt/openssl/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/openssl/include"
export PKG_CONFIG_PATH="$(brew --prefix)/opt/openssl/lib/pkgconfig"

# Tcl/Tk for Tkinter support
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"

# --- Java Setup ---
# Choose one Java installation. For JDK 23, use:
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-23.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# --- Go Environment ---
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# --- Flutter Settings ---
export FLUTTER_ROOT="$HOME/Developments/Flutter/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"

bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
