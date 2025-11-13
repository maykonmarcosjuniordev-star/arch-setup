#!/bin/bash

echo "installing nvidias drives"
yay -Sy --needed --noconfirm nvidia nvidia-prime nvidia-utils libva-nvidia-driver

sudo ln -sfn ~/arch-setup/config/essentials/nvidia.conf /etc/modprobe.d/nvidia.conf

echo "replacing binaries in usr/bin/ to run with prime-run"

echo "for brave"
# verify if brave-real already exists to avoid overwriting
if [ -f /usr/bin/brave-real ]; then
    echo "/usr/bin/brave-real already exists. Skipping brave replacement."
else
    echo "Backing up existing brave binary to brave-real"
    sudo mv /usr/bin/brave /usr/bin/brave-real
    echo '#!/bin/bash
    exec prime-run /usr/bin/brave-real "$@"' | sudo tee /usr/bin/brave
    sudo chmod +x /usr/bin/brave
fi

echo "for vs-code"
# verify if code-real already exists to avoid overwriting
if [ -f /usr/bin/code-real ]; then
    echo "/usr/bin/code-real already exists. Skipping code replacement."
else
    echo "Backing up existing code binary to code-real"
    sudo mv /usr/bin/code /usr/bin/code-real
    echo '#!/bin/bash
    exec prime-run /usr/bin/code-real "$@"' | sudo tee /usr/bin/code
    sudo chmod +x /usr/bin/code
fi

echo "for firefox"
# verify if firefox-real already exists to avoid overwriting
if [ -f /usr/bin/firefox-real ]; then
    echo "/usr/bin/firefox-real already exists. Skipping firefox replacement."
else
    echo "Backing up existing firefox binary to firefox-real"
    sudo mv /usr/bin/firefox /usr/bin/firefox-real
    echo '#!/bin/bash
    exec prime-run /usr/bin/firefox-real "$@"' | sudo tee /usr/bin/firefox
    sudo chmod +x /usr/bin/firefox
fi

echo "for vlc"
# verify if vlc-real already exists to avoid overwriting
if [ -f /usr/bin/vlc-real ]; then
    echo "/usr/bin/vlc-real already exists. Skipping vlc replacement."
else
    echo "Backing up existing vlc binary to vlc-real"
    sudo mv /usr/bin/vlc /usr/bin/vlc-real
    echo '#!/bin/bash
    exec prime-run /usr/bin/vlc-real "$@"' | sudo tee /usr/bin/vlc
    sudo chmod +x /usr/bin/vlc
fi
