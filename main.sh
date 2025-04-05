#!/bin/bash
mkdir -p ~/Downloads
mkdir -p ~/Github
mkdir -p ~/Music
mkdir -p ~/Pictures
# essentials that need pacman
sudo pacman -Suy --needed < pacman.list
# install yay
sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
sudo chown -R $(whoami):$(whoami) /opt/yay-git/
cd /opt/yay-git
makepkg -sirc
cd ~
yay -Suy
# install apps
yay -Sy --needed - < yay.list
make -f src/*.mk

# TODO: Config files
#ln -sf "$(pwd)"/config/* ~/.config/

# Setup man-pages
#mandb

# allowing for ssh push
git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
eval "$(ssh-agent -s)"
echo "Download the ssh keys from the google drive bkp and run
ssh-add ~/.ssh/main/id_ed25519"
