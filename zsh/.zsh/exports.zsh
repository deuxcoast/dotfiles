
# Locale
# I have locale set in the alacritty config.
# export LANG="en_US.UTF-8"
# export LANGUAGE="en_US.UTF-8"

# FZF Catppucin Mocha Colorscheme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#000000,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


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
