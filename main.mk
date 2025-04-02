apps=(
  "yay"
  "gmail"
  "nvidia"
  "orange"
  "rust"
  "whatsapp"
)

all:
  mkdir ~/Downloads
  mkdir ~/Downloads/Wine
  mkdir ~/Downloads/AppImage
  mkdir ~/Github
  mkdir ~/Music
  mkdir ~/Pictures
  yay
  yay -S --needed - < apps.list

yay:
  sudo pacman -S --needed git base-devel
  cd /opt
  sudo git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -sirc
  cd ~
