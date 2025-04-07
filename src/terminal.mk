all:
	ln -sf "$(pwd)"/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sf "$(pwd)"/config/terminal/.bashrc ~/.bashrc
	ln -sf "$(pwd)"/config/terminal/kitty.conf ~/.config/kitty/kitty.conf
	ln -sf "$(pwd)"/config/terminal/current-theme.conf ~/.config/kitty/current-theme.conf
