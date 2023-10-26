#! /bin/bash

CPU="$(uname -m)" 

TMUX_CONF_PATH="${HOME}/.dotfiles/tmux/.config/tmux/tmux.conf"

if [[ "$CPU" = "arm64" ]]; then
    
    printf '%s\n\n%s\n' "source-file ~/.config/tmux/arm.conf" "source-file ~/.config/tmux/minimal.conf" > "$TMUX_CONF_PATH"
    
elif [[ "$CPU" = "x86_64" ]]; then 

    printf '%s\n\n%s\n' "source-file ~/.config/tmux/x86.conf" "source-file ~/.config/tmux/minimal.conf" > "$TMUX_CONF_PATH"

fi
