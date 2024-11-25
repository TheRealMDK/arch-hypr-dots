#!/bin/bash

# Directory where wallpapers are stored
WALLPAPER_DIR=$HOME/arch-hypr-dots/home/user/wallpapers/live

# Delay between wallpaper changes in seconds (adjust to your preference)
DELAY=60  # 1 minute

# Function to get a random wallpaper
get_random_wallpaper() {
    find "$WALLPAPER_DIR" -type f -name "*.mp4" | shuf -n 1
}

# Loop indefinitely to change wallpapers
while true; do
    # Get a random wallpaper file
    wallpaper=$(get_random_wallpaper)

    # Kill all existing mpvpaper instances
    pkill -x mpvpaper

    # Launch mpvpaper with the new wallpaper for each specified monitor
    mpvpaper HDMI-A-1 "$wallpaper" -o "loop=yes hwdec=no no-audio" &
    mpvpaper HDMI-A-4 "$wallpaper" -o "loop=yes hwdec=no no-audio" &

    # Wait for the specified delay before changing the wallpaper again
    sleep "$DELAY"
done
