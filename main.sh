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
sudo pacman -Suy --needed --noconfirm - < ~/arch-setup/apps/pacman.list
# install yay
echo "installing yay"
# verify if yay-git directory exists
if [ ! -d /opt/yay-git ]; then
    sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
    sudo chown -R $(whoami):$(whoami) /opt/yay-git/
    cd /opt/yay-git
    makepkg -sirc
    cd ~/arch-setup
fi
yay -Suy
# install apps
sudo chmod +x src/*.sh
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
read -p "Do you want to install NVIDIA drivers? (y/n): " install_nvidia
if [[ "$install_nvidia" == "y" || "$install_nvidia" == "Y" ]]; then
    ./src/gpu.sh
fi
read -p "Do you want to use Hyprland? (y/n): " install_hyprland
if [[ "$install_hyprland" == "y" || "$install_hyprland" == "Y" ]]; then
    ./src/hyprland.sh
fi
read -p "Do you want to use GNOME? (y/n): " apply_gnome
if [[ "$apply_gnome" == "y" || "$apply_gnome" == "Y" ]]; then
    ./src/gnome.sh apply
fi
read -p "Do you want to use Cosmic Desktop? (y/n): " apply_cosmic
if [[ "$apply_cosmic" == "y" || "$apply_cosmic" == "Y" ]]; then
    ./src/cosmic.sh
fi

# reboot if allowed
read -p "Reboot now (recommended)? (y/n): " reboot_now
if [[ "$reboot_now" == "y" || "$reboot_now" == "Y" ]]; then
    reboot
fi