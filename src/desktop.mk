all:
	systemctl --user enable --now gmail-tray.service
	sudo mkdir -p /usr/local/share/fonts
	sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
	sudo fc-cache -vf
	ln -sf ~/arch-setup/icons ~/.local/share/
	ln -sf ~/arch-setup/config/dconf/*.desktop ~/.local/share/applications/
	ln -sf ~/arch-setup/config/dconf/discord.desktop ~/.config/autostart/
	ln -sf ~/arch-setup/config/dconf/notion.desktop ~/.config/autostart/

