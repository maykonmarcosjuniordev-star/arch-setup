alias list='cat ~/.bash_aliases'
alias upd='sudo pacman -Suy --noconfirm && yay -Suy --noconfirm && sudo pacman -Qdtq | sudo pacman -Qdtq | xargs -r pacman -Rns --noconfirm'
alias get_music='yt-dlp --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s"'
alias set_ssh='eval "$(ssh-agent -s)"
ssh-add ~/.ssh/main/id_ed25519
ssh-add ~/.ssh/ufsc/id_ed25519
ssh-add ~/.ssh/arch'