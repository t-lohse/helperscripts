#!/bin/sh

neo() {
    #termite -e "neofetch" --hold &
    foot -HF neofetch &
    #sleep 0.5
    #swaymsg fullscreen
    #zoom (xdotool but for wayland)
    lock=$(swaylock -C $cLoc)
    swaymsg kill
}

pic() {
    echo "$path" >> "$cLoc"
    exec swaylock -C  $cLoc &
    wait
    grep -v "$path" "$cLoc" > delete.me && mv -f delete.me "$cLoc"
}

cLoc="/home/lohse/dotfiles/swaylock/config"
bgDir="$HOME/Documents/Pictures/Lockscreen/"

((num = $(ls $bgDir | wc -l)))
if [ $(shuf -n 1 -i 1-$num) = $num ]; then
    neo
else
    path="image=$(find $bgDir -type f | shuf -n 1)"
    pic
fi

