#!/bin/bash
set -e

# set own user permissions for arch-setup folder
sudo chown -R $(whoami):$(whoami) ~/arch-setup/
sudo chown -R $(whoami):$(whoami) ~/arch-setup/.*

# Double-check we have connectivity before continuing
if ! ping -c1 archlinux.org &>/dev/null; then
    echo "=== Ativando conexão de rede ==="
    bash ~/arch-setup/src/network.sh
fi


# essentials that need pacman
echo "installing essential apps with pacman"
sudo pacman -Suy --needed --noconfirm git pacman-contrib base-devel

# install yay
echo "installing yay"
bash ~/arch-setup/src/yay.sh

echo "installing essential apps with yay"
bash ~/arch-setup/src/essentials.sh

echo "installing GPU drivers (if any)"
bash ~/arch-setup/src/gpu.sh

echo "decrypting credentials"
bash ~/arch-setup/src/crypt.sh d

# create symlinks
echo "creating symlinks for terminal settings"
bash ~/arch-setup/src/terminal.sh symlinks
git remote set-url origin git@github.com:maykonmarcosjuniordev-star/arch-setup
git lfs pull
bash ~/arch-setup/src/desktop.sh

read -p "Do you want to use Hyprland? (y/N): " install_hyprland
if [[ "$install_hyprland" == "y" || "$install_hyprland" == "Y" ]]; then
    bash ~/arch-setup/src/hyprland.sh
fi
read -p "Do you want to use GNOME? (y/N): " apply_gnome
if [[ "$apply_gnome" == "y" || "$apply_gnome" == "Y" ]]; then
    bash ~/arch-setup/src/gnome.sh apply
    read -p "Do you want to load GNOME settings? (y/N): " copy_gnome_settings
    if [[ "$copy_gnome_settings" == "y" || "$copy_gnome_settings" == "Y" ]]; then
        bash ~/arch-setup/src/gnome.sh load
    fi
fi
read -p "Do you want to use Cosmic Desktop? (y/N): " apply_cosmic
if [[ "$apply_cosmic" == "y" || "$apply_cosmic" == "Y" ]]; then
    bash ~/arch-setup/src/cosmic.sh
fi

# reboot if allowed
read -p "Reboot now (recommended)? (y/N): " reboot_now
if [[ "$reboot_now" == "y" || "$reboot_now" == "Y" ]]; then
    reboot
fi