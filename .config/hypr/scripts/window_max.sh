#!/bin/bash

# 取得螢幕的寬、高、與縮放比
# 縮放比可能為小數，為避免浮點計算問題，先乘10，之後再除回來
MONITOR_WIDTH_HEIGHT_SCALE=$(hyprctl monitors -j | jq -r 'map(select(.focused == true)) | .[] | (.width|tostring) + " " + (.height|tostring) + " " + (.scale*10|floor|tostring)')
read MONITOR_WIDTH MONITOR_HEIGHT SCALE <<< $MONITOR_WIDTH_HEIGHT_SCALE

# 取得狀態列高度
STATUSBAR_HEIGHT=$(hyprctl monitors -j | jq -r 'map(select(.focused == true)) | .[] | .reserved[1]')

# 取得視窗間隙
HYPRLAND_GAPS_OUT=$(hyprctl getoptions general:gaps_out -j | jq -r '.int')
# 取得視窗邊框大小
HYPRLAND_BORDER_SIZE=$(hyprctl getoptions general:border_size -j | jq -r '.int')

# 計算視窗最大化可用寬度
AVAILABLE_WIDTH=$((MONITOR_WIDTH*10/SCALE - HYPRLAND_GAPS_OUT*2 - HYPRLAND_BORDER_SIZE*2))
# 計算視窗最大化可用高度
AVAILABLE_HEIGHT=$((MONITOR_HEIGHT*10/SCALE - STATUSBAR_HEIGHT - HYPRLAND_GAPS_OUT*2 - HYPRLAND_BORDER_SIZE*2))

# 取得目前視窗是否浮動中
floating=$(hyprctl activewindow -j | jq '.floating')
# 視窗非浮動時，切成浮動狀態，並放到最大置中
# 視窗浮動時，切回非浮動（平鋪）狀態
if [[ $floating == 'false' ]];then
    hyprctl dispatch togglefloating
    hyprctl dispatch resizeactive exact $AVAILABLE_WIDTH $AVAILABLE_HEIGHT
    hyprctl dispatch centerwindow 1
else
    hyprctl dispatch togglefloating
fi
