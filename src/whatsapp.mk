# https://aur.archlinux.org/packages/altus-bin
all:
  echo "get the AppImage from https://github.com/amanharwara/altus/releases"
  #git clone https://aur.archlinux.org/altus-bin.git
  #cd altus-bin/
  #makepkg -sirc
  git clean -dfx
  sudo pacman -U altus-bin-*-x86_64.pkg.tar.zst

clean:
  sudo pacman -R altus-bin  
