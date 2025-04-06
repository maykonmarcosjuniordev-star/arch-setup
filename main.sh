#!/bin/bash
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
yay -Sy --needed - < essentials.list
yay -Sy --needed - < gnome.list
yay -Sy --needed - < hypr.list
yay -Sy --needed - < desktop.list

# applying configs
make -f src/*.mk

# Config files on home
ln -sf "$(pwd)"/config/* ~/.config/
ln -sf "$(pwd)"/config/.bash_aliases ~/.bash_aliases
ln -sf "$(pwd)"/config/.bashrc ~/.bashrc

# Setup man-pages
#mandb

# allowing for ssh push
git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
eval "$(ssh-agent -s)"
echo "Download the ssh keys from the google drive bkp and run the following command:"
ssh-add ~/.ssh/main/id_ed25519
