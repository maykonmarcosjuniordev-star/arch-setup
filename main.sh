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

# Config files on home
for app in echo src/*.mk; do
    # Aqui você pode adicionar o comando para instalar o aplicativo específico
    make -f $app
done

# Setup man-pages
#mandb

# allowing for ssh push
git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
eval "$(ssh-agent -s)"
read -p "Baixou as chaves ssh do bkp no drive (y/n) " confirm
if [[ $confirm == "y" || $confirm == "Y" ]]; then
    ssh-add ~/.ssh/main/id_ed25519
    ssh-add ~/.ssh/ufsc/id_ed25519
fi
