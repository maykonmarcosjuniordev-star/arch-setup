all:
	systemctl --user enable --now gmail-tray.service
	sudo mkdir -p /usr/local/share/fonts
	sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
	sudo fc-cache -vf
	ln -sf ~/arch-setup/icons ~/.local/share/
	ln -sf ~/arch-setup/config/dconf/*.desktop ~/.local/share/applications/
	ln -sf ~/arch-setup/config/dconf/discord.desktop ~/.config/autostart/
	ln -sf ~/arch-setup/config/dconf/notion.desktop ~/.config/autostart/
	mkdir -p ~/MEGA/Main
	mkdir -p ~/MEGA/Hobby
	mkdir -p ~/MEGA/UFSC
	mkdir -p ~/.mozilla/firefox/Main/
	mkdir -p ~/.mozilla/firefox/Hobby/
	mkdir -p ~/.mozilla/firefox/UFSC/
# 	ln -sf ~/.mozilla/firefox/Main/prefs.js  ~/MEGA/Main/
# 	ln -sf ~/.mozilla/firefox/Hobby/prefs.js ~/MEGA/Hobby/
# 	ln -sf ~/.mozilla/firefox/UFSC/prefs.js  ~/MEGA/UFSC/
	cp  ~/MEGA/Main/ ~/.mozilla/firefox/Main/prefs.js
	cp ~/MEGA/Hobby/ ~/.mozilla/firefox/Hobby/prefs.js
	cp  ~/MEGA/UFSC/ ~/.mozilla/firefox/UFSC/prefs.js

