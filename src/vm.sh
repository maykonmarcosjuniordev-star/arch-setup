#!/bin/bash

git clone https://github.com/quickemu-project/quickemu.git
yay -Suy  --needed --noconfirm ventoy-bin qemu-full spice spice-gtk
yay -Suy  --needed --noconfirm wine winetricks wine-gecko wine-mono
yay -Suy  --needed --noconfirm waydroid
yay -Suy  --needed --noconfirm darling-bin
yay -Suy  --needed --noconfirm gnome-boxes-git
yay -Suy  --needed --noconfirm virtualbox-bin
