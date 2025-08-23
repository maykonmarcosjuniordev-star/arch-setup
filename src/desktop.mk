all:
	systemctl --user enable --now gmail-tray.service
	sudo mkdir -p /usr/local/share/fonts
	sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
	cp ~/arch-setup/config/tray/.fetchmailrc ~/.fetchmailrc
	sudo fc-cache -vf
	ln -sf ~/arch-setup/icons ~/.local/share/
	ln -sf ~/arch-setup/config/dconf/*.desktop ~/.local/share/applications/
	ln -sf ~/arch-setup/config/dconf/discord.desktop ~/.config/autostart/
	ln -sf ~/arch-setup/config/dconf/notion.desktop ~/.config/autostart/
	ln -sf ~/arch-setup/config/dconf/wasistlos.conf ~/.config/wasistlos/settings.conf
	mkdir -p ~/MEGA/Main
	mkdir -p ~/MEGA/Hobby
	mkdir -p ~/MEGA/UFSC
	mkdir -p ~/.mozilla/firefox/Main/
	mkdir -p ~/.mozilla/firefox/Hobby/
	mkdir -p ~/.mozilla/firefox/UFSC/

	cp  ~/MEGA/Main/prefs.js  ~/.mozilla/firefox/Main/prefs.js
	cp ~/MEGA/Hobby/prefs.js ~/.mozilla/firefox/Hobby/prefs.js
	cp  ~/MEGA/UFSC/prefs.js  ~/.mozilla/firefox/UFSC/prefs.js
	cp  ~/MEGA/Main/addons.json  ~/.mozilla/firefox/Main/addons.json
	cp ~/MEGA/Hobby/addons.json ~/.mozilla/firefox/Hobby/addons.json
	cp  ~/MEGA/UFSC/addons.json  ~/.mozilla/firefox/UFSC/addons.json
	cp  ~/MEGA/Main/extensions.json  ~/.mozilla/firefox/Main/extensions.json
	cp ~/MEGA/Hobby/extensions.json ~/.mozilla/firefox/Hobby/extensions.json
	cp  ~/MEGA/UFSC/extensions.json  ~/.mozilla/firefox/UFSC/extensions.json
	cp  ~/MEGA/Main/extension-settings.json ~/.mozilla/firefox/Main/extension-settings.json 
	cp ~/MEGA/Hobby/extension-settings.json ~/.mozilla/firefox/Hobby/extension-settings.json
	cp  ~/MEGA/UFSC/extension-settings.json ~/.mozilla/firefox/UFSC/extension-settings.json 
	cp  ~/MEGA/Main/extension-preferences.json ~/.mozilla/firefox/Main/extension-preferences.json 
	cp ~/MEGA/Hobby/extension-preferences.json ~/.mozilla/firefox/Hobby/extension-preferences.json
	cp  ~/MEGA/UFSC/extension-preferences.json ~/.mozilla/firefox/UFSC/extension-preferences.json 


backup:
	cp  ~/.mozilla/firefox/Main/prefs.js  ~/MEGA/Main/prefs.js
	cp ~/.mozilla/firefox/Hobby/prefs.js ~/MEGA/Hobby/prefs.js
	cp  ~/.mozilla/firefox/UFSC/prefs.js  ~/MEGA/UFSC/prefs.js
	cp  ~/.mozilla/firefox/Main/addons.json  ~/MEGA/Main/addons.json
	cp ~/.mozilla/firefox/Hobby/addons.json ~/MEGA/Hobby/addons.json
	cp  ~/.mozilla/firefox/UFSC/addons.json  ~/MEGA/UFSC/addons.json
	cp  ~/.mozilla/firefox/Main/extensions.json  ~/MEGA/Main/extensions.json
	cp ~/.mozilla/firefox/Hobby/extensions.json ~/MEGA/Hobby/extensions.json
	cp  ~/.mozilla/firefox/UFSC/extensions.json  ~/MEGA/UFSC/extensions.json
	cp  ~/.mozilla/firefox/Main/extension-settings.json  ~/MEGA/Main/extension-settings.json
	cp ~/.mozilla/firefox/Hobby/extension-settings.json ~/MEGA/Hobby/extension-settings.json
	cp  ~/.mozilla/firefox/UFSC/extension-settings.json  ~/MEGA/UFSC/extension-settings.json
	cp  ~/.mozilla/firefox/Main/extension-preferences.json  ~/MEGA/Main/extension-preferences.json
	cp ~/.mozilla/firefox/Hobby/extension-preferences.json ~/MEGA/Hobby/extension-preferences.json
	cp  ~/.mozilla/firefox/UFSC/extension-preferences.json  ~/MEGA/UFSC/extension-preferences.json

