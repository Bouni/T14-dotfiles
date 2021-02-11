#!/bin/bash

STATUS=$($HOME/.config/polybar/scripts/get_playerctl_status.sh)

if [ "$STATUS" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$STATUS" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar -c $HOME/.config/polybar/config-1 bottommain")" hook pause 2 >/dev/null
    playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
elif [ "$STATUS" = "No player is running"  ]; then
    echo $STATUS
else
    polybar-msg -p "$(pgrep -f "polybar -c $HOME/.config/polybar/config-1 bottommain")" hook pause 1 >/dev/null
    playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}"
fi
