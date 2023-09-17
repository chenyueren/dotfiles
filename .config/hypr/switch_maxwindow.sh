#!/bin/bash
floating=$(hyprctl activewindow -j | jq '.floating')
if [[ $floating == 'false' ]];then
    hyprctl dispatch togglefloating
    hyprctl dispatch resizeactive exact 1896 1026
    hyprctl dispatch centerwindow 1
else
    hyprctl dispatch togglefloating
fi
