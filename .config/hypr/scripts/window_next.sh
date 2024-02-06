#!/bin/bash

MONITOR_WIDTH_HEIGHT_SCALE=$(hyprctl monitors -j | jq -r 'map(select(.focused == true)) | .[] | (.width|tostring) + " " + (.height|tostring) + " " + (.scale*10|floor|tostring)')
read MONITOR_WIDTH MONITOR_HEIGHT SCALE <<< $MONITOR_WIDTH_HEIGHT_SCALE
STATUSBAR_HEIGHT=$(hyprctl monitors -j | jq -r 'map(select(.focused == true)) | .[] | .reserved[1]')
HYPRLAND_GAPS_OUT=$(hyprctl getoptions general:gaps_out -j | jq -r '.int')
HYPRLAND_BORDER_SIZE=$(hyprctl getoptions general:border_size -j | jq -r '.int')
AVAILABLE_WIDTH=$((MONITOR_WIDTH*10/SCALE - HYPRLAND_GAPS_OUT*2 - HYPRLAND_BORDER_SIZE*2))
AVAILABLE_HEIGHT=$((MONITOR_HEIGHT*10/SCALE - STATUSBAR_HEIGHT - HYPRLAND_GAPS_OUT*2 - HYPRLAND_BORDER_SIZE*2))


floating=$(hyprctl activewindow -j | jq '.floating')
if [[ $floating == 'false' ]];then
    hyprctl dispatch cyclenext
else
    hyprctl dispatch togglefloating
    hyprctl dispatch cyclenext
    hyprctl dispatch togglefloating
    hyprctl dispatch resizeactive exact $AVAILABLE_WIDTH $AVAILABLE_HEIGHT
    hyprctl dispatch centerwindow 1
fi
