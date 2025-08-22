all:
	mkdir -p ~/.config/kitty
	ln -sf ~/arch-setup/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sf ~/arch-setup/config/terminal/.bashrc ~/.bashrc
	ln -sf ~/arch-setup/config/terminal/.bash_profile ~/.bash_profile
	ln -sf ~/arch-setup/config/terminal/kitty.conf ~/.config/kitty/kitty.conf
	ln -sf ~/arch-setup/config/terminal/current-theme.conf ~/.config/kitty/current-theme.conf
	read -p "insira o email para a ssh" email
	ssh-keygen -t ed25519 -C "$email"
	cat ~/.ssh/id_ed25519.pub
	echo "Copie o resultado anterior e cole em: https://github.com/settings/ssh/new"
	eval "$(ssh-agent -s)"
	chmod 600 ~/.ssh/id_ed25519
	ssh-add ~/.ssh/id_ed25519
	curl -sS https://starship.rs/install.sh | sh
