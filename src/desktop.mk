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

	if [read -p "Do you want to setup Firefox profiles? (y/n) " choice && [[ $choice == [Yy]* ]]; then
		setup_firefox
	fi

setup_firefox:
	mkdir -p ~/.mozilla/firefox/Main/
	mkdir -p ~/.mozilla/firefox/Hobby/
	mkdir -p ~/.mozilla/firefox/UFSC/
	mkdir -p ~/.mozilla/firefox/Dev/
	mkdir -p ~/.mozilla/firefox/Lax/
	ln -sf  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Main/user.js
	ln -sf  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Hobby/user.js
	ln -sf  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/UFSC/user.js
	ln -sf  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Dev/user.js
# 	ln -sf  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Lax/user.js
# 	cp  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Hobby/
# 	cp  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Main/
# 	cp  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/UFSC/
# 	cp  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Dev/
	cp  ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/Lax/

