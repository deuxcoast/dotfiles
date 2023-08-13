# Initialize $PATH with system and user binaries
export VISUAL=nvim

# Default editor nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.npm-global/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export DOOM="$HOME/.emacs.d/bin/doom:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/protobuf/bin:$PATH"

# Add homebrew programs to PATH, only on macs.
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ "$CPUTYPE" == "arm64" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
fi


# Source zsh-completions plugin
# This must be run before `source "$ZSH/oh-my-zsh.sh"`
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Locale
# I have locale set in the alacritty config.
# export LANG="en_US.UTF-8"
# export LANGUAGE="en_US.UTF-8"

# Zsh
export ZSH="$HOME/.oh-my-zsh"

# fzf.
export FZF_DEFAULT_OPTS=" \
    --color=fg:#c0c5ce,bg:#212121,hl:#808080,fg+:#e6e6e6,bg+:#3b3b3b,hl+:#f7c662 \
    --color=info:#f7c662,prompt:#6699cc,pointer:#a6bc69,marker:#a6bc69,spinner:#f7c662,header:#6699cc"

# nnn
export NNN_BMS="d:~/Downloads;D:~/Documents;t:~/Temporary" # Bookmarks
export NNN_FCOLORS="03040601000205f7d204d9f7" # File colors
export NNN_PLUG="D:-!mediainfo \$nnn" # Plugins
export NNN_TRASH=1 # Trash instead of delete the files

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Less
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$'\e[1;31m' # Start blinking
export LESS_TERMCAP_md=$'\e[1;34m' # Start bold mode
export LESS_TERMCAP_me=$'\e[0m' # End all mode
export LESS_TERMCAP_so=$'\e[38;5;215m' # Start standout mode
export LESS_TERMCAP_se=$'\e[0m' # End standout mode
export LESS_TERMCAP_us=$'\e[4;35m' # Start underline
export LESS_TERMCAP_ue=$'\e[0m' # End underline
