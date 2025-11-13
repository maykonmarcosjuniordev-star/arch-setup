#!/bin/bash

echo "installing hyprland and related apps"
yay -Sy --needed --noconfirm - < apps/hyprland.list

# enabling services
echo "enabling hyprland-related services"
systemctl --user enable --now hyprlux.service
systemctl --user enable --now hyprpolkitagent


# creating symlinks for hyprland config
echo "creating symlinks for hyprland config"
mkdir -p ~/.config/hypr
ln -sfn ~/arch-setup/config/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sfn ~/arch-setup/config/hyprland/waybar ~/.config/waybar
chmod +x ~/arch-setup/config/hyprland/waybar/powermenu.sh
ln -sfn ~/arch-setup/config/hyprland/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sfn ~/arch-setup/config/hyprland/hyprlock.conf ~/.config/hypr/hyprlock.conf
mkdir -p ~/.config/sunsetr
ln -sfn ~/arch-setup/config/hyprland/sunsetr.toml ~/.config/sunsetr/sunsetr.toml
systemctl --user enable sunsetr.service
# setting wallpaper
echo "setting wallpaper"
mkdir -p ~/Pictures
ln -sfn ~/arch-setup/wallpapers/ ~/Pictures/Wallpapers

echo "removing needless kitty installation"
yay -Rns --noconfirm kitty

