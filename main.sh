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
ln -sf "$(pwd)"/config/.bash_aliases ~/.bash_aliases
ln -sf "$(pwd)"/config/.bashrc ~/.bashrc
ln -sf "$(pwd)"/config/* ~/.config/

# applying special configs
for app in echo src/*.mk; do
    #read -p "Deseja instalar o aplicativo $app? (y/n) " confirm
    #if [[ $confirm == "y" || $confirm == "Y" ]]; then
    # Aqui você pode adicionar o comando para instalar o aplicativo específico
    make -f $app
    #else
    #    echo "Ignorando a instalação de $app."
    #fi
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
