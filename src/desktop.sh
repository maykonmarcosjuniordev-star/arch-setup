#!/bin/bash

echo "installing desktop applications"
yay -Sy --needed --noconfirm - < ~/arch-setup/apps/desktop.list

# 	create symlinks for configuration files and directories
#   app icons, wallpapers, applications, autostart entries, and wasistlos config
echo "creating symlinks for configuration files and directories"

echo "Settings Default Applications"
mkdir -p ~/.config
ln -sfn ~/arch-setup/config/mimeapps.list ~/.config/mimeapps.list

echo "linking icons, wallpapers, applications, and bin directories"
mkdir -p ~/.local/share/icons
ln -sfn ~/arch-setup/icons/* ~/.local/share/icons/
# in case it's required to copy icons to system pixmaps
# sudo cp ~/arch-setup/icons/* /usr/share/pixmaps/
# custom desktop applications
mkdir -p ~/.local/share/applications/
ln -sfn ~/arch-setup/.local/applications/* ~/.local/share/applications/
# wallpapers
mkdir -p ~/.local/share/
ln -sfn ~/arch-setup/wallpapers ~/.local/share/backgrounds
# custom bin scripts
mkdir -p ~/.local/bin/
sudo chmod +x ~/arch-setup/.local/bin/*
ln -sfn ~/arch-setup/.local/bin/* ~/.local/bin/
sudo ln -sfn ~/arch-setup/.local/applications/firefox.desktop /usr/share/applications/firefox.desktop

mkdir -p ~/.config/autostart
ln -sfn ~/arch-setup/.local/applications/notion.desktop ~/.config/autostart/
ln -sfn ~/arch-setup/.local/applications/discord.desktop ~/.config/autostart/

echo "linking application configurations"
# neovim configuration
mkdir -p ~/.config/nvim
ln -sfn ~/arch-setup/config/nvim/init.lua ~/.config/nvim/init.lua
git clone --depth=1 https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim

# vs code configuration
mkdir -p ~/.config/Code/User
ln -sfn ~/arch-setup/config/vs-code/settings.json ~/.config/Code/User/settings.json
ln -sfn ~/arch-setup/config/vs-code/keybindings.json ~/.config/Code/User/keybindings.json

# whatsapp desktop configuration
mkdir -p ~/.config/Altus
ln -sfn ~/arch-setup/config/whatsapp/* ~/.config/Altus/

# Firefox configuration for multiple profiles
echo "setting up Firefox configuration for multiple profiles"
mkdir -p ~/.mozilla/firefox/Main/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Main/user.js
mkdir -p ~/.mozilla/firefox/UFSC/
ln -sfn  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/UFSC/user.js

# Audacious media player configuration
echo "setting up Audacious configuration"
mkdir -p ~/.config/audacious
ln -sfn ~/arch-setup/config/audacious/config ~/.config/audacious/config
ln -sfn ~/arch-setup/config/audacious/plugin-registry ~/.config/audacious/plugin-registry

# yazi desktop pet configuration
echo "setting up Yazi desktop pet configuration"
ln -sfn ~/arch-setup/config/yazi/ ~/.config/yazi

# GHOSTTY terminal emulator configuration
echo "setting up GHOSTTY terminal emulator configuration"
mkdir -p ~/.config/ghostty
ln -sfn ~/arch-setup/config/ghostty/ghostty.conf ~/.config/ghostty/config

# 	copy dummy fetchmail 
echo "linking fetchmail configuration to ~/.fetchmailrc"
chmod 600 ~/arch-setup/credentials/fetchmailrc
ln -sfn ~/arch-setup/credentials/fetchmailrc ~/.fetchmailrc
ln -sfn ~/arch-setup/config/gmail-tray/gmail-tray-configs.json ~/.config/gmail-tray/

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
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Mocha-Cursors"
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-Mocha-Standard-Default"
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-green-standard+default"

# to hide desktop entriees from the launcher
hide_list=(
  'avahi-discover'
  'bssh'
  'bvnc'
  'calibre-ebook-edit'
  'calibre-ebook-viewer'
  'calibre-lrfviewer'
  'ccmake'
  'cmake'
  'cmake-gui'
  'lstop'
  'mpv'
  'nm-connection-editor'
  'nvim'
  'qv4l2'
  'qvidcap'
  'wl-kbptr'
  'xgps'
  'xgpsspeed'
)
path="/usr/share/applications"
for app in "${hide_list[@]}"; do
  if [ -f "$path/$app.desktop" ]; then
    echo "Hiding $app from application launcher"
    # if NoDisplay is not present, add it
    if ! grep -q "NoDisplay=" "$path/$app.desktop"; then
      sudo sed -i '/\[Desktop Entry\]/a NoDisplay=true' "$path/$app.desktop"
      continue
    fi
    sudo sed -i 's/NoDisplay=false/NoDisplay=true/g' "$path/$app.desktop"
  fi
done