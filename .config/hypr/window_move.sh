#!/bin/bash

WORKSPACE_ID=$(hyprctl activewindow -j | jq '.workspace.id')


if [ $1 == "left" ];then
    hyprctl dispatch movetoworkspace $((WORKSPACE_ID-1))
elif [ $1 == "right" ];then
    hyprctl dispatch movetoworkspace $((WORKSPACE_ID+1))
fi
