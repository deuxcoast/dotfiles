# '.zshrc' is sourced in interactive shells.
# It should be used to set aliases, functions, options, key bindings, etc.
#
# --- Theme / Prompt
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # Should improve zsh-autosuggestions performance

# --- Environment variables
source ${HOME}/.zsh/exports.zsh

# --- Oh My Zsh
# Plugins must be defined before sourcing oh-my-zsh
# zsh-autosuggestions plugin must be sourced last
plugins=(
    fd
    gh
    git
    golang
    fzf-tab
    mosh
    ripgrep
    sudo
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source ${ZSH}/oh-my-zsh.sh

# Start tmux immediately upon opening a new shell.
# Attach to 'default' session, or create 'default'
# session if it does not exist
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi


# --- Aliases
source ${HOME}/.zsh/aliases.zsh

# --- Functions
source ${HOME}/.zsh/functions.zsh

# --- Set options
source ${HOME}/.zsh/setopt.zsh

# --- Private config
source ${HOME}/.zsh/privaterc.zsh

# Enable fzf keybindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Change keybinding for autosuggestion expansion
bindkey '^ ' autosuggest-accept # <C-space>

eval "$(pyenv init -)"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd j zsh)"
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

