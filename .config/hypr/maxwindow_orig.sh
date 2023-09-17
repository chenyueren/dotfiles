#!/bin/bash
# https://github.com/hyprwm/Hyprland/issues/1278
#
#will output monitor name, width ,height subtracting gaps and panels
hyprctl monitors -j \
    | jq -r 'map(select(.focused == true)) | .[] | .name + " " +(.width|tostring) + " " + (.height|tostring)' \
    | { read -r name width height;
    # check if panel is running, and subtract 2x20
    # always subtract 2x outer gapsize (= 2x6=12)

    gapsize=$(hyprctl getoption general:gaps_out -j | jq -r '.int')
    margin=$((2 * gapsize))

    width=$(($width-$margin))

    pgrep waybar &> /dev/null && margin=$(($margin + 40))
    height=$(($height - $margin))

    #subtract double border size of available monitor dims
    borderSize=$(hyprctl getoption general:border_size -j | jq -r '.int')
    newX=$(( $width - 2 * $borderSize ))
    newY=$(( $height - 2 * $borderSize ))


    echo $newX $newY
    hyprctl dispatch togglefloating
    hyprctl dispatch resizeactive exact $(($newX /2)) $(($newY/2))
    hyprctl dispatch centerwindow 1
}
