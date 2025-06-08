all:
	systemctl --user enable --now gmail-tray.service
	chmod +x config/notion/patch-notion-enhanced.linux.sh
	sudo ~/arch-setup/config/notion/patch-notion-enhanced.linux.sh
	ln -sf ~/arch-setup/config/notion/.notion-enhancer ~/.notion-enhancer
	sudo mkdir -p /usr/local/share/fonts
	sudo cp ~/arch-setup/fonts/* /usr/local/share/fonts
	sudo fc-cache -vf
	ln -sf ~/arch-setup/icons ~/.local/share/
	cp ~/arch-setup/config/dconf/*.desktop ~/.local/share/applications/

