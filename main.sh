#!/bin/bash
# essentials that need pacman
sudo pacman -Suy --needed --noconfirm - < apps/pacman.list
# install yay
sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
sudo chown -R $(whoami):$(whoami) /opt/yay-git/
cd /opt/yay-git
makepkg -sirc
cd ~/arch-setup
yay -Suy
# install apps
yay -Sy --needed --noconfirm - < apps/essentials.list
make -f src/preconfig.mk
yay -Sy --needed --noconfirm - < apps/gnome.list
yay -Sy --needed --noconfirm - < apps/desktop.list

# Config files on home
make -f src/essentials.mk
make -f src/gnome.mk
make -f src/desktop.mk
make -f src/audacious.mk