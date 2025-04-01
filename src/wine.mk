# https://wiki.archlinux.org/title/Wine
all:
  sudo pacman -Suy wine

clean:
  sudo pacman -R wine
