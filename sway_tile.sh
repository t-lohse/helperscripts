#!/bin/env bash

kill_win() {
    notify-send "W: $width | H: $height"
    HW=$(echo "scale = 2; $height/$width" | bc -l)
    WH=$(echo "scale = 2; $width/$height" | bc -l)
    notify-send "H/W: $HW | W/H: $WH"
    swaymsg kill
}

width=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .rect.width')
height=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .rect.height')

for arg in "$@"; do
    if [ "$arg" == "kill" ]; then
        kill_win
        exit
    fi
done

if [ $(( height > width )) = 1 ]; then  #Splits
    swaymsg splitv #Vertivally if the focused windows height is greater than the width
else
    swaymsg splith  #And vice versa
fi

$1  ## Takes first argument as the program to be executed
exit
