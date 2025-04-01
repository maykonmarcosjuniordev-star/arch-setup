all:
  sudo pacman -Suy ffmpeg ytdlp wmctrl

clean:
  sudo pacman -R ffmpeg ytdlp wmctrl
