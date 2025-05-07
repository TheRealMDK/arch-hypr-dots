#!/bin/bash

display="$1"
wallpaper="$2"

#GENERATE A NEW COLOR PALLET USING WALL

wal -q -n -s -t -i "$wallpaper"
# wal -q -i "$wallpaper"

#SYMLINK THE NEW COLOR THEME TO THE WAYBAR CONFIG AND RESTART WAYBAR
ln -sf ~/.cache/wal/colors-waybar.css ~/arch-hypr-dots/usr/share/themes/Material_Black_Cherry/colors-wal.css
killall -SIGUSR2 waybar
