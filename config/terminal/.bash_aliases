alias list='cat ~/.bash_aliases'
alias upd='sudo pacman -Suy --noconfirm && yay -Suy --noconfirm && sudo pacman -Qdtq | sudo pacman -Qdtq | sudo xargs -r pacman -Rns --noconfirm'
alias get_music='yt-dlp --format bestaudio --extract-audio --audio-format mp3 --audio-quality 192K --output "%(title)s.%(ext)s"'
alias bkp="make -f arch-setup/src/desktop.mk backup
make -f arch-setup/src/gnome.mk dump"
