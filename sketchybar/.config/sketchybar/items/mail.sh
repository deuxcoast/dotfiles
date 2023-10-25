#!/bin/bash

sketchybar           --add item mail left                                      \
                     --set      mail script="$PLUGIN_DIR/noti_mail.sh"         \
                                     update_freq=60                            \
                                     padding_left=2                            \
                                     padding_right=2                           \
                                     background.border_width=0                 \
                                     background.height=24                      \
                                     icon="$ICON_MAIL"                         \
                                     icon.color="$BLUE"                        \
                                     label.color="$BLUE"                       \
