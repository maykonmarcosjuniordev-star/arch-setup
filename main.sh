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

mkdir -p ~/.config/
echo "creating symlink for pacman.conf"
ln -sfn ~/arch-setup/config/aur/pacman.conf ~/.config/pacman.conf
ln -sfn ~/arch-setup/config/aur/makepkg.conf ~/.config/makepkg.conf

# essentials that need pacman
echo "installing essential apps with pacman"
sudo pacman -Suy --needed --noconfirm base-devel git pacman-contrib rustup
echo "enabling cargo"
rustup default stable

echo "installing paru"
bash ~/arch-setup/src/paru.sh

echo "installing essential apps"
bash ~/arch-setup/src/essentials.sh

echo "installing GPU drivers (if any)"
bash ~/arch-setup/src/gpu.sh

echo "decrypting credentials"
# if credentials are encrypted, decrypt them
read -p "Do you want to decrypt credentials? (y/N): " cred_encrypted
if [[ "$cred_encrypted" == "y" || "$cred_encrypted" == "Y" ]]; then
    bash ~/arch-setup/src/crypt.sh d
fi

# create symlinks
echo "creating symlinks for terminal settings"
bash ~/arch-setup/src/terminal.sh symlinks
bash ~/arch-setup/src/terminal.sh set_git

echo "installing and setting up main desktop applications"
bash ~/arch-setup/src/desktop.sh

echo "installing hyprland and related apps"
bash ~/arch-setup/src/hyprland.sh

# reboot if allowed
read -p "Reboot now (recommended)? (y/N): " reboot_now
if [[ "$reboot_now" == "y" || "$reboot_now" == "Y" ]]; then
    reboot
fi