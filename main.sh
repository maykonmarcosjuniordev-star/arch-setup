#!/bin/bash
mkdir ~/Downloads
mkdir ~/Github
mkdir ~/Music
mkdir ~/Pictures
# essentials that need pacman
sudo pacman -Suy --needed < pacman.list
# install yay
cd /opt/
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $(whoami):$(whoami) yay-git/
cd yay-git
makepkg -sirc
yay -Suy
cd ~
# install apps
yay -Sy --needed - < yay.list
make -f src/rust.mk
make -f src/nvidia.mk
make -f src/orange.mk
cd ~

# TODO: Config files
#ln -sf "$(pwd)"/config/* ~/.config/

# Setup man-pages
#mandb
