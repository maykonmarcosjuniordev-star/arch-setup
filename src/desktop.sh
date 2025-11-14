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
ln -sfn ~/arch-setup/icons ~/.local/share/
ln -sfn ~/arch-setup/wallpapers ~/.local/share/backgrounds
ln -sfn ~/arch-setup/.local/applications ~/.local/share/applications
ln -sfn ~/arch-setup/.local/bin ~/.local/bin
ln -sfn ~/arch-setup/.local/applications/notion.desktop ~/.config/autostart/
ln -sfn ~/arch-setup/config/gnome/wasistlos.conf ~/.config/wasistlos/settings.conf

# Firefox configuration for multiple profiles
echo "setting up Firefox configuration for multiple profiles"
mkdir -p ~/.mozilla/firefox/Hobby/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Hobby/user.js
mkdir -p ~/.mozilla/firefox/Main/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Main/user.js
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
echo "moving fetchmail configuration to ~/.fetchmailrc"
mv ~/arch-setup/tmp/.fetchmailrc ~/.fetchmailrc

# 	enable gmail-tray service
echo "enabling gmail-tray service"
systemctl --user enable --now gmail-tray.service

# 	copy fonts and update font cache
echo "copying fonts to /usr/local/share/fonts and updating font cache"
sudo mkdir -p /usr/local/share/fonts
sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
sudo fc-cache -vf