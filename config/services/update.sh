#!/bin/bash

# Aguarda conexão com a internet
for i in {1..60}; do
    if ping -c1 archlinux.org &>/dev/null; then
        break
    fi
    sleep 1
done

# Atualização automática
pacman -Suy --noconfirm
yay -Suy --noconfirm
pacman -Qdtq | xargs -r pacman -Rns --noconfirm

