#!/bin/bash
# essentials that need pacman
echo "installing essential apps with pacman"
sudo pacman -Suy --needed --noconfirm - < apps/pacman.list
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
chmod +x src/*.sh
echo "installing essential apps with yay"
./src/essentials.sh
# create symlinks
echo "creating symlinks for terminal settings"
./src/terminal.sh create_symlinks
read -p "Do you want to generate SSH keys? (y/n): " generate_keys
if [[ "$generate_keys" == "y" || "$generate_keys" == "Y" ]]; then
    ./src/terminal.sh gen_key
fi
./src/desktop.sh
read -p "Do you want to install NVIDIA drivers? (y/n): " install_nvidia
if [[ "$install_nvidia" == "y" || "$install_nvidia" == "Y" ]]; then
    ./src/nvidia.sh
fi
read -p "Do you want to use GNOME? (y/n): " apply_gnome
if [[ "$apply_gnome" == "y" || "$apply_gnome" == "Y" ]]; then
    ./src/gnome.sh apply
fi
read -p "Do you want to use Cosmic Desktop? (y/n): " apply_cosmic
if [[ "$apply_cosmic" == "y" || "$apply_cosmic" == "Y" ]]; then
    ./src/cosmic.sh
fi
read -p "Do you want to install Hyprland and related apps? (y/n): " install_hyprland
if [[ "$install_hyprland" == "y" || "$install_hyprland" == "Y" ]]; then
    ./src/hyprland.sh
fi
read -p "Do you want to set up virtual machine support? (y/n): " setup_vm
if [[ "$setup_vm" == "y" || "$setup_vm" == "Y" ]]; then
    ./src/vm.sh
fi

# set correct git remote
git remote set-url origin git@github.com:maykonmarcosjuniordev-star/arch-setup.git
