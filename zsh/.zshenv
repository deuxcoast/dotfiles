# - Exports
#
# '.zshev' is sourced on all invocations of the shell, unless the -f option
# is set.
#
# This file should be used to set our PATH and other important environment
# variables, but should not include commands that produce output or assume
# the shell is attached to a tty.

export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="$VISUAL"
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

export XDG_CONFIG_HOME="$HOME/.config"

export CONDA_AUTO_ACTIVATE_BASE=false

# Rust
source "$HOME/.cargo/env"

# This removes duplicate entries from $PATH
typeset -U PATH path


# Add homebrew install directory to PATH for ARM Macs
[[ $(uname -ms) = "Darwin arm64" ]] && export PATH="/opt/homebrew/bin:$PATH"
. "$HOME/.cargo/env"
