PATH="${HOME}/.local/bin:$PATH"

# Add homebrew install directory to PATH for ARM Macs
[[ $(uname -ms) = "Darwin arm64" ]] && PATH="/opt/homebrew/bin:$PATH"

# Start tmux if not already in tmux.
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi


#################################################################
# Sourcing
#################################################################

for file in "${HOME}/.zsh/prompts.zsh" \
            "${HOME}/.zsh/aliases.zsh" \
            "${HOME}/.zsh/set_history.zsh" \
            "${HOME}/.zsh/zinit.zsh" \
            "${HOME}/.zsh/completions.zsh"
do
    [ -s "${file}" ] && source "${file}"
done

#################################################################
# Key Bindings
#################################################################

# Cycle through command history with <C-p> and <C-n>
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

up-directory() {
    builtin cd ..
    if (( $? == 0 )); then
        local precmd
        for precmd in $precmd_functions; do
            $precmd
        done
        zle reset-prompt
    fi
}

# Move to parent directory with <C-b> 
zle -N up-directory
bindkey "^B" up-directory

# Set some options
setopt interactive_comments extended_glob autocd complete_aliases
