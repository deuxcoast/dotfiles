# PATH env vars are exported from ~/.zshenv
# This file is for sourcing and exporting env vars for various CLI tools

# Source zsh-completions plugin
# This must be run before `source "$ZSH/oh-my-zsh.sh"`
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=${HOME}/.zsh/functions/

export LS_COLORS=$(vivid generate catppuccin-mocha)

export FZF_DEFAULT_COMMAND="fd --type f --color=never --hidden"
export FZF_DEFAULT_OPTS="--height=50% --min-height=15 --reverse"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}' --height=50%"

export FZF_ALT_C_COMMAND="fd --type d . --color=never --hidden"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50' --height=50%"

# FZF Catppucin Mocha Colorscheme
export FZF_DEFAULT_OPTS=" \
--no-height \
--color=bg+:#313244,bg:#000000,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/rg/config"

# Less
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$'\e[1;31m' # Start blinking
export LESS_TERMCAP_md=$'\e[1;34m' # Start bold mode
export LESS_TERMCAP_me=$'\e[0m' # End all mode
export LESS_TERMCAP_so=$'\e[38;5;215m' # Start standout mode
export LESS_TERMCAP_se=$'\e[0m' # End standout mode
export LESS_TERMCAP_us=$'\e[4;35m' # Start underline
export LESS_TERMCAP_ue=$'\e[0m' # End underline
