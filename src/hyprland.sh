#!/bin/bash

echo "installing hyprland and related apps"
paru -Sy --needed --noconfirm - < ~/arch-setup/apps/hyprland.list


# creating symlinks for hyprland config
echo "creating symlinks for hyprland config"
mkdir -p ~/.config/hypr
ln -sfn ~/arch-setup/config/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sfn ~/arch-setup/config/hyprland/conf ~/.config/hypr/conf
ln -sfn ~/arch-setup/config/hyprland/waybar ~/.config/waybar
ln -sfn ~/arch-setup/config/hyprland/wofi ~/.config/wofi
ln -sfn ~/arch-setup/config/hyprland/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sfn ~/arch-setup/config/hyprland/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -sfn ~/arch-setup/config/hyprland/hypridle.conf ~/.config/hypr/hypridle.conf
mkdir -p ~/.config/hypr/wl-kbptr
ln -sfn ~/arch-setup/config/hyprland/wl-kbptr.conf ~/.config/hypr/wl-kbptr/config
mkdir -p ~/.config/sunsetr
ln -sfn ~/arch-setup/config/hyprland/sunsetr.toml ~/.config/sunsetr/sunsetr.toml
ln -sfn ~/arch-setup/config/hyprland/sunsetr.service ~/.config/systemd/user/default.target.wants/
ln -sfn ~/arch-setup/config/hyprland/sunsetr.service ~/.config/systemd/user/graphical-session.target.wants/


# enabling services
echo "enabling hyprland-related services"
systemctl --user enable --now hyprpolkitagent
systemctl --user enable --now hypridle
systemctl --user enable --now sunsetr