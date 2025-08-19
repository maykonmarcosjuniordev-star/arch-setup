all:
	mkdir -p ~/.config/kitty
	ln -sf ~/arch-setup/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sf ~/arch-setup/config/terminal/.bashrc ~/.bashrc
	ln -sf ~/arch-setup/config/terminal/.bash_profile ~/.bash_profile
	ln -sf ~/arch-setup/config/terminal/kitty.conf ~/.config/kitty/kitty.conf
	ln -sf ~/arch-setup/config/terminal/current-theme.conf ~/.config/kitty/current-theme.conf
	curl -sS https://starship.rs/install.sh | sh
