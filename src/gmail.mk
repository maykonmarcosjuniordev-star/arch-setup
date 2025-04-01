# https://aur.archlinux.org/packages/gmail-desktop-bin
all:
  echo "download AppImage from https://github.com/timche/meru/releases"
  #git clone https://aur.archlinux.org/gmail-desktop-bin.git
  #cd gmail-desktop-bin/
  #makepkg -sirc
  #git clean -dfx

clean:
  sudo rm ~/.AppImage/
  #sudo pacman -R gmail-desktop-bin
