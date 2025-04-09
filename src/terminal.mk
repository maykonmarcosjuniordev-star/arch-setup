all:
	ln -sf ~/arch-setup/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sf ~/arch-setup/config/terminal/.bashrc ~/.bashrc
	ln -sf ~/arch-setup/config/terminal/kitty.conf ~/.config/kitty/kitty.conf
	ln -sf ~/arch-setup/config/terminal/current-theme.conf ~/.config/kitty/current-theme.conf
	# allowing for ssh push
	git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
	eval "$(ssh-agent -s)"
	read -p "Baixou as chaves ssh do bkp no drive (y/n) " confirm
	if [[ $confirm == "y" || $confirm == "Y" ]]; then
		ssh-add ~/.ssh/main/id_ed25519
		ssh-add ~/.ssh/ufsc/id_ed25519
	fi
