#!/bin/bash

WORKSPACE_ID=$(hyprctl activeworkspace -j | jq '.id')


if [ $1 == "left" ];then
    hyprctl dispatch workspace $((WORKSPACE_ID-1))
elif [ $1 == "right" ];then
    hyprctl dispatch workspace $((WORKSPACE_ID+1))
fi
