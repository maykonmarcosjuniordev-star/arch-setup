#!/bin/bash

echo "installing desktop applications"
yay -Sy --needed --noconfirm - < ~/arch-setup/apps/desktop.list

# 	create symlinks for configuration files and directories
#   app icons, wallpapers, applications, autostart entries, and wasistlos config
echo "creating symlinks for configuration files and directories"
sudo chmod +x ~/arch-setup/.local/bin/*
mkdir -p ~/.local/share/
mkdir -p ~/.config/autostart
mkdir -p ~/.config/wasistlos
ln -sfn ~/arch-setup/icons ~/.local/share
# in case it's required to copy icons to system pixmaps
# sudo cp ~/arch-setup/icons/* /usr/share/pixmaps/
ln -sfn ~/arch-setup/wallpapers ~/.local/share/backgrounds
ln -sfn ~/arch-setup/.local/applications ~/.local/share/applications
ln -sfn ~/arch-setup/.local/bin ~/.local/bin

sudo ln -sfn ~/arch-setup/.local/applications/firefox.desktop /usr/share/applications/firefox.desktop
ln -sfn ~/arch-setup/.local/applications/notion.desktop ~/.config/autostart/
ln -sfn ~/arch-setup/config/gnome/wasistlos.conf ~/.config/wasistlos/settings.conf
ln -sfn ~/arch-setup/config/vs-code/settings.json ~/.config/Code/User/settings.json
ln -sfn ~/arch-setup/config/vs-code/keybindings.json ~/.config/Code/User/keybindings.json

# Firefox configuration for multiple profiles
echo "setting up Firefox configuration for multiple profiles"
mkdir -p ~/.mozilla/firefox/UFSC/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/UFSC/user.js
mkdir -p ~/.mozilla/firefox/Dev/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Dev/user.js
mkdir -p ~/.mozilla/firefox/Lax/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Lax/user.js

# Audacious media player configuration
echo "setting up Audacious configuration"
mkdir -p ~/.config/audacious
ln -sfn ~/arch-setup/config/audacious/config ~/.config/audacious/config
ln -sfn ~/arch-setup/config/audacious/plugin-registry ~/.config/audacious/plugin-registry

# 	copy dummy fetchmail 
echo "linking fetchmail configuration to ~/.fetchmailrc"
ln -sfn ~/arch-setup/tmp/fetchmailrc ~/.fetchmailrc
chmod 600 ~/.fetchmailrc

# 	enable gmail-tray service
echo "enabling gmail-tray service"
systemctl --user enable --now gmail-tray.service

# 	copy fonts and update font cache
echo "copying fonts to /usr/local/share/fonts and updating font cache"
sudo mkdir -p /usr/local/share/fonts
sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
sudo fc-cache -vf

# setting up qt5ct configuration
echo "setting up themes configuration"
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-red-standard+default"
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-Mocha-Standard-Default"
gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Mocha-Cursors"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
