# --- Theme / Prompt 
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # Should improve zsh-autosuggestions performance
DISABLE_LS_COLORS=true

# --- Environment variables
source $HOME/.zsh/.exports

# --- Oh My Zsh
plugins=(git sudo golang zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# --- Aliases
source $HOME/.zsh/.aliases

# --- Functions
source $HOME/.zsh/.functions

# --- Private config
source $HOME/.zsh/.privaterc

# --- Zsh Syntax Highlighting
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Auto Jump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

