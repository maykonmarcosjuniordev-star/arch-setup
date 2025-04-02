#!/bin/bash
mkdir ~/Downloads
mkdir ~/Github
mkdir ~/Music
mkdir ~/Pictures
sudo pacman -S --needed git base-devel nodejs
# install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -sirc
cd ..
rm -rf yay-bin
# install apps
yay -S --needed - < apps.list
make -f src/rust.mk
make -f src/nvidia.mk
make -f src/orange.mk

# Config files
#ln -sf "$(pwd)"/config/* ~/.config/

# Setup man-pages
#mandb
