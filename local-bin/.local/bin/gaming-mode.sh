#!/bin/bash
# ~/.local/bin/gaming-mode.sh

# List of env vars to preserve
PRESERVED_VARS="DXVK_FRAME_RATE PROTON_ENABLE_NVAPI PROTON_HIDE_NVIDIA_GPU __GL_SHADER_DISK_CACHE __GL_SHADER_DISK_CACHE_PATH DISPLAY XAUTHORITY HOME USER LOGNAME PATH"

# Function to cleanup on exit
cleanup() {
    echo "Restoring normal system settings..."
    systemctl --user start kanata
    killall -CONT waybar
    notify-send "Gaming Mode" "Deactivated - System restored"
}

trap cleanup EXIT

echo "Activating gaming mode..."

# Stop keyboard remapping
systemctl --user stop kanata

# Pause resource-intensive services
killall -STOP waybar

# Notify
notify-send "Gaming Mode" "Activated - System optimized for gaming"

# Launch game with clean environment
exec env -i \
    $(for var in $PRESERVED_VARS; do
        if [ -n "${!var}" ]; then
            echo "$var=${!var}"
        fi
    done) \
    DXVK_FRAME_RATE=144 \
    PROTON_ENABLE_NVAPI=1 \
    PROTON_HIDE_NVIDIA_GPU=0 \
    __GL_SHADER_DISK_CACHE=1 \
    __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv" \
    gamemoderun "$@"
