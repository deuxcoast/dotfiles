# skip_global_compinit=1

# - Exports

export ZSH=$HOME/.oh-my-zsh
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Rust
source "$HOME/.cargo/env"

# Source zsh-completions plugin
# This must be run before `source "$ZSH/oh-my-zsh.sh"`
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=${HOME}/.zsh/functions/


# remove duplicate entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path


# Add homebrew install directory to PATH for ARM Macs
[[ $(uname -ms) = "Darwin arm64" ]] && export PATH="/opt/homebrew/bin:$PATH"
