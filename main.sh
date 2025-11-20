#!/bin/bash
# first ensuring 
echo "granting user rights for the setup"
sudo chown -R $(whoami):$(whoami) ~/arch-setup


# Double-check we have connectivity before continuing
if ! ping -c1 archlinux.org &>/dev/null; then
    echo "=== Ativando conexão de rede ==="
    ./src/network.sh
fi


# essentials that need pacman
echo "installing essential apps with pacman"
sudo pacman -Suy --needed --noconfirm git pacman-contrib
# install apps
sudo chmod +x src/*.sh

# install yay
echo "installing yay"
./src/yay.sh

echo "installing essential apps with yay"
./src/essentials.sh

echo "decrypting credentials"
./src/crypt.sh decrypt

# create symlinks
echo "creating symlinks for terminal settings"
./src/terminal.sh create_symlinks
git remote set-url origin git@github.com:maykonmarcosjuniordev-star/arch-setup
git lfs pull
./src/desktop.sh
read -p "Do you want to install GPU drivers? (y/N): " install_gpu
if [[ "$install_gpu" == "y" || "$install_gpu" == "Y" ]]; then
    ./src/gpu.sh
fi
read -p "Do you want to use Hyprland? (y/N): " install_hyprland
if [[ "$install_hyprland" == "y" || "$install_hyprland" == "Y" ]]; then
    ./src/hyprland.sh
fi
read -p "Do you want to use GNOME? (y/N): " apply_gnome
if [[ "$apply_gnome" == "y" || "$apply_gnome" == "Y" ]]; then
    ./src/gnome.sh apply
    read -p "Do you want to load GNOME settings? (y/N): " copy_gnome_settings
    if [[ "$copy_gnome_settings" == "y" || "$copy_gnome_settings" == "Y" ]]; then
        ./src/gnome.sh load
    fi
fi
read -p "Do you want to use Cosmic Desktop? (y/N): " apply_cosmic
if [[ "$apply_cosmic" == "y" || "$apply_cosmic" == "Y" ]]; then
    ./src/cosmic.sh
fi

# reboot if allowed
read -p "Reboot now (recommended)? (y/N): " reboot_now
if [[ "$reboot_now" == "y" || "$reboot_now" == "Y" ]]; then
    reboot
fi