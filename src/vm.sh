#!/bin/bash

git clone https://github.com/quickemu-project/quickemu.git
paru -Suy  --needed --noconfirm ventoy-bin qemu-full spice spice-gtk
paru -Suy  --needed --noconfirm wine winetricks wine-gecko wine-mono
paru -Suy  --needed --noconfirm waydroid
paru -Suy  --needed --noconfirm darling-bin
paru -Suy  --needed --noconfirm gnome-boxes-git
paru -Suy  --needed --noconfirm virtualbox-bin
