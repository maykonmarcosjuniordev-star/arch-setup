all:
  git clone https://aur.archlinux.org/visual-studio-code-bin.git
  cd visual-studio-code-bin/
  makepkg -sirc
  git clean -dfx
  sudo pacman -U visual-studio-code-bin-*-x86_64.pkg.tar.zst

clean:
  sudo pacman -R visual-studio-code-bin
