all:
	git lfs install
	git add .gitattributes
	mkdir -p ~/.config/environment.d/
	cp ~/arch-setup/config/environment.d/ibus.conf ~/.config/environment.d/ibus.conf
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
	export INPUT_METHOD=ibus
	mkdir -p ~/.config/systemd/user
	ln -sf ~/arch-setup/config/terminal/ssh-agent.service ~/.config/systemd/user/ssh-agent.service
	ln -sf ~/arch-setup/config/terminal/ssh-add.service ~/.config/systemd/user/ssh-add.service
	ln -sf ~/arch-setup/config/terminal/.profile ~/.profile
	systemctl --user daemon-reexec
	systemctl --user daemon-reload
	systemctl --user enable --now ssh-agent.service
	systemctl --user enable --now ssh-add.service
	git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
	eval "$(ssh-agent -s)"
	read -p "Baixou as chaves ssh do bkp no drive (y/n) " confirm
	if [[ $confirm == "y" || $confirm == "Y" ]]; then
		ssh-add ~/.ssh/main/id_ed25519
		ssh-add ~/.ssh/ufsc/id_ed25519
	fi
	systemctl status bluetooth.service
	sudo usermod -aG video $USER
