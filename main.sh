#!/bin/bash
# essentials that need pacman
sudo pacman -Suy --needed - < apps/pacman.list
# install yay
sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
sudo chown -R $(whoami):$(whoami) /opt/yay-git/
cd /opt/yay-git
makepkg -sirc
cd ~/arch-setup
yay -Suy
# install apps
yay -Sy --needed - < apps/essentials.list
make -f preconfig.mk
yay -Sy --needed - < apps/gnome.list
# yay -Sy --needed - < apps/hypr.list
yay -Sy --needed - < apps/desktop.list

# Config files on home
for app in echo src/*.mk; do
    make -f $app
done

# Setup man-pages
#mandb
