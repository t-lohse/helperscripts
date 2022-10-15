#!/bin/sh
sudo pacman -Scc
ORPHANS=$(sudo pacman -Qdtq)

if [ -z "$ORPHANS" ]; then
    echo 'No orphaned packages.'
else
    count=$($ORPHANS | wc -l)
    echo "$count orphaned packages to be removed."
    sudo pacman -Rsn $(pacman -Qdtq)
fi
