#!/bin/bash

echo "installing hyprland and related apps"
yay -Sy --needed --noconfirm - < apps/hyprland.list

# enabling services
echo "enabling hyprland-related services"
systemctl --user enable --now hyprlux.service

# Add these variables to your Hyprland config:
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = ELECTRON_OZONE_PLATFORM_HINT,auto
env = NVD_BACKEND,direct
