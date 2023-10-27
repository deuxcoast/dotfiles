# --- Theme / Prompt
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # Should improve zsh-autosuggestions performance
DISABLE_LS_COLORS=true

# --- Environment variables
source ${HOME}/.zsh/exports.zsh

# --- Oh My Zsh
# These plugins may or not be installed on the system already. If not installed,
# find the package on github and follow the instructions. zsh-syntax-highlighting
# and zsh-autosuggestions need to be installed according to instructions using
# oh-my-zsh plugin manager (see the packages gh pages for instructions)
#
# zsh-autosuggestions must be sourced last
plugins=(git sudo golang autojump zsh-syntax-highlighting zsh-autosuggestions)

source ${ZSH}/oh-my-zsh.sh

# start tmux immediately
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# --- Change keybinding for autosuggestion expansion
bindkey '^ ' autosuggest-accept # <C-space>

# --- Aliases
source ${HOME}/.zsh/aliases.zsh

# --- Functions
source ${HOME}/.zsh/functions.zsh

# --- Set options
source ${HOME}/.zsh/setopt.zsh

# --- Private config
source ${HOME}/.zsh/privaterc.zsh
