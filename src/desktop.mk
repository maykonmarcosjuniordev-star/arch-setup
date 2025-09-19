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
# 	mkdir -p ~/arch-setup/config/firefox/Profiles/Main
# 	mkdir -p ~/arch-setup/config/firefox/Profiles/Hobby
# 	mkdir -p ~/arch-setup/config/firefox/Profiles/UFSC
	mkdir -p ~/.mozilla/firefox/Main/
	mkdir -p ~/.mozilla/firefox/Hobby/
	mkdir -p ~/.mozilla/firefox/UFSC/

	cp  ~/arch-setup/config/firefox/Profiles/Main/prefs.js  ~/.mozilla/firefox/Main/prefs.js
	cp ~/arch-setup/config/firefox/Profiles/Hobby/prefs.js ~/.mozilla/firefox/Hobby/prefs.js
	cp  ~/arch-setup/config/firefox/Profiles/UFSC/prefs.js  ~/.mozilla/firefox/UFSC/prefs.js
	cp  ~/arch-setup/config/firefox/Profiles/Main/addons.json  ~/.mozilla/firefox/Main/addons.json
	cp ~/arch-setup/config/firefox/Profiles/Hobby/addons.json ~/.mozilla/firefox/Hobby/addons.json
	cp  ~/arch-setup/config/firefox/Profiles/UFSC/addons.json  ~/.mozilla/firefox/UFSC/addons.json
	cp  ~/arch-setup/config/firefox/Profiles/Main/extensions.json  ~/.mozilla/firefox/Main/extensions.json
	cp ~/arch-setup/config/firefox/Profiles/Hobby/extensions.json ~/.mozilla/firefox/Hobby/extensions.json
	cp  ~/arch-setup/config/firefox/Profiles/UFSC/extensions.json  ~/.mozilla/firefox/UFSC/extensions.json
	cp  ~/arch-setup/config/firefox/Profiles/Main/extension-settings.json ~/.mozilla/firefox/Main/extension-settings.json 
	cp ~/arch-setup/config/firefox/Profiles/Hobby/extension-settings.json ~/.mozilla/firefox/Hobby/extension-settings.json
	cp  ~/arch-setup/config/firefox/Profiles/UFSC/extension-settings.json ~/.mozilla/firefox/UFSC/extension-settings.json 
	cp  ~/arch-setup/config/firefox/Profiles/Main/extension-preferences.json ~/.mozilla/firefox/Main/extension-preferences.json 
	cp ~/arch-setup/config/firefox/Profiles/Hobby/extension-preferences.json ~/.mozilla/firefox/Hobby/extension-preferences.json
	cp  ~/arch-setup/config/firefox/Profiles/UFSC/extension-preferences.json ~/.mozilla/firefox/UFSC/extension-preferences.json 


backup:
	cp  ~/.mozilla/firefox/Main/prefs.js  ~/arch-setup/config/firefox/Profiles/Main/prefs.js
	cp ~/.mozilla/firefox/Hobby/prefs.js ~/arch-setup/config/firefox/Profiles/Hobby/prefs.js
	cp  ~/.mozilla/firefox/UFSC/prefs.js  ~/arch-setup/config/firefox/Profiles/UFSC/prefs.js
	cp  ~/.mozilla/firefox/Main/addons.json  ~/arch-setup/config/firefox/Profiles/Main/addons.json
	cp ~/.mozilla/firefox/Hobby/addons.json ~/arch-setup/config/firefox/Profiles/Hobby/addons.json
	cp  ~/.mozilla/firefox/UFSC/addons.json  ~/arch-setup/config/firefox/Profiles/UFSC/addons.json
	cp  ~/.mozilla/firefox/Main/extensions.json  ~/arch-setup/config/firefox/Profiles/Main/extensions.json
	cp ~/.mozilla/firefox/Hobby/extensions.json ~/arch-setup/config/firefox/Profiles/Hobby/extensions.json
	cp  ~/.mozilla/firefox/UFSC/extensions.json  ~/arch-setup/config/firefox/Profiles/UFSC/extensions.json
	cp  ~/.mozilla/firefox/Main/extension-settings.json  ~/arch-setup/config/firefox/Profiles/Main/extension-settings.json
	cp ~/.mozilla/firefox/Hobby/extension-settings.json ~/arch-setup/config/firefox/Profiles/Hobby/extension-settings.json
	cp  ~/.mozilla/firefox/UFSC/extension-settings.json  ~/arch-setup/config/firefox/Profiles/UFSC/extension-settings.json
	cp  ~/.mozilla/firefox/Main/extension-preferences.json  ~/arch-setup/config/firefox/Profiles/Main/extension-preferences.json
	cp ~/.mozilla/firefox/Hobby/extension-preferences.json ~/arch-setup/config/firefox/Profiles/Hobby/extension-preferences.json
	cp  ~/.mozilla/firefox/UFSC/extension-preferences.json  ~/arch-setup/config/firefox/Profiles/UFSC/extension-preferences.json

