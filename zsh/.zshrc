# --- Theme / Prompt
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # Should improve zsh-autosuggestions performance
DISABLE_LS_COLORS=true

# --- Environment variables
source $HOME/.zsh/.exports

# --- Oh My Zsh
# These plugins may or not be installed on the system already. If not installed,
# find the package on github and follow the zsh-syntax-highlighting and
# zsh-autosuggestions need to be installed according to instructions using
# oh-my-zsh plugin manager (see the packages gh pages for instructions)
#
# zsh-autosuggestions must be sourced last
plugins=(git sudo golang autojump zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# --- Aliases
source $HOME/.zsh/.aliases

# --- Functions
source $HOME/.zsh/.functions
source $HOME/.zsh/functions/_alacritty

# --- Private config
source $HOME/.zsh/.privaterc