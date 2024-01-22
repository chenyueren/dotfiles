swayidle -w timeout 1500 'swaylock -f -c 000000' \
            timeout 3000 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            before-sleep 'swaylock -f -c 000000' &
