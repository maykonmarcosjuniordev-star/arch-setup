#!/bin/bash

echo "installing essential apps"
yay -Sy --needed --noconfirm - < ~/arch-setup/apps/essentials.list
yay -Sy --needed --noconfirm - < ~/arch-setup/apps/rust.list

for app in $(cat ~/arch-setup/apps/cargo.list); do
    cargo install $app
done

# enable linger for user to allow services to run without active login
echo "enabling linger for user $USER"
loginctl enable-linger $USER
systemctl enable sddm
systemctl enable --now systemd-homed

# IBus configuration
echo "configuring IBus"
mkdir -p ~/.config/environment.d/
ln -sfn ~/arch-setup/config/ibus.conf ~/.config/environment.d/ibus.conf
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export INPUT_METHOD=ibus

# Enable pipewire and bluetooth services
echo "enabling pipewire and bluetooth services"
systemctl --user enable --now pipewire pipewire-pulse wireplumber
systemctl enable bluetooth.service
wpctl settings --save bluetooth.autoswitch-to-headset-profile false
sudo usermod -aG video $USER
sudo rmmod uvcvideo
sudo modprobe -r uvcvideo
sudo modprobe uvcvideo

# Enable power-profiles-daemon service
echo "enabling power-profiles-daemon service"
sudo systemctl enable power-profiles-daemon.service
sudo systemctl start power-profiles-daemon.service
