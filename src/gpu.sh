#!/bin/bash

echo "installing nvidias drives"
yay -Sy --needed --noconfirm nvidia nvidia-prime nvidia-utils libva-nvidia-driver

# sudo ln -sfn ~/arch-setup/config/essentials/nvidia.conf /etc/modprobe.d/nvidia.conf

#echo "
#WLR_RENDERER=vulkan
#GBM_BACKEND=nvidia-drm
#__GLX_VENDOR_LIBRARY_NAME=nvidia
#" | sudo tee -a /etc/environment

#mkdir -p ~/.config/environment.d
#echo "
#MOZ_ENABLE_WAYLAND=1
#CLUTTER_BACKEND=wayland
#QT_QPA_PLATFORM=wayland
#SDL_VIDEODRIVER=wayland
#" | sudo tee -a ~/.config/environment.d/wayland.conf