#!/bin/bash

echo "set_background.sh started with arguments: $@" >> /tmp/set_background.log

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image1> <image2>" >> /tmp/set_background.log
    exit 1
fi

IMAGE1="$1"
IMAGE2="$2"
CURRENT_WALLPAPER="$HOME/.cache/swww/cache.txt"
ABSOLUTE_PATH_IMAGE1=$(realpath "$IMAGE1")
ABSOLUTE_PATH_IMAGE2=$(realpath "$IMAGE2")

echo "Setting wallpapers: $ABSOLUTE_PATH_IMAGE1 and $ABSOLUTE_PATH_IMAGE2" >> /tmp/set_background.log

# Define monitor names
MONITOR1="HDMI-A-1"
MONITOR2="DP-3"

echo "Using monitors: $MONITOR1 and $MONITOR2" >> /tmp/set_background.log

# Set wallpaper for monitor 1
swww img -o "$MONITOR1" "$IMAGE1" --resize crop

# Set wallpaper for monitor 2
swww img -o "$MONITOR2" "$IMAGE2" --resize crop

# Update the cache file
echo "$ABSOLUTE_PATH_IMAGE1" > "$CURRENT_WALLPAPER"
echo "$ABSOLUTE_PATH_IMAGE2" >> "$CURRENT_WALLPAPER"

notify-send "Wallpapers Changed" -i "$ABSOLUTE_PATH_IMAGE1" "Monitor 1: $IMAGE1\nMonitor 2: $IMAGE2"
echo "set_background.sh completed" >> /tmp/set_background.log
