# https://www.vivaolinux.com.br/dica/Removendo-Firefox-Snap-do-Ubuntu-2204
all:
  sudo pacman -Suy firefox

clean:
  sudo pacman -R firefox
