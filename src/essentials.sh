#!/bin/bash

echo "installing essential apps"
yay -Sy --needed --noconfirm - < apps/essentials.list

# import gpg key for git lfs
echo "importing gpg key for git lfs"
gpg --keyserver hkps://keys.openpgp.org --recv-keys 14F26682D0916CDD81E37B6D61B7B526D98F0353

# enable linger for user to allow services to run without active login
echo "enabling linger for user $USER"
loginctl enable-linger $USER
echo "installing and configuring git lfs"
git lfs install
# track the problematic asset paths with LFS and commit .gitattributes
# git lfs track "icons/*" "wallpapers/*"
# git add .gitattributes
# git commit -m "Track icons and wallpapers with Git LFS"
### rewrite history converting existing files into LFS objects across all refs
# git lfs migrate import --include="icons/*,wallpapers/*" --everything

# IBus configuration
echo "configuring IBus"
mkdir -p ~/.config/environment.d/
ln -sfn ~/arch-setup/config/environment.d/ibus.conf ~/.config/environment.d/ibus.conf
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export INPUT_METHOD=ibus

# Enable pipewire and bluetooth services
echo "enabling pipewire and bluetooth services"
systemctl --user enable --now pipewire pipewire-pulse wireplumber
systemctl enable bluetooth.service
sudo usermod -aG video $USER
sudo rmmod uvcvideo
sudo modprobe -r uvcvideo
sudo modprobe uvcvideo
