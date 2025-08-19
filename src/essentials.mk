all:
	loginctl enable-linger $USER
	git lfs install
	git add .gitattributes
	mkdir -p ~/.config/environment.d/
	cp ~/arch-setup/config/environment.d/ibus.conf ~/.config/environment.d/ibus.conf
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
	export INPUT_METHOD=ibus
	systemctl enable gdm.service
	systemctl --user enable --now pipewire pipewire-pulse wireplumber
	systemctl enable bluetooth.service
	sudo usermod -aG video $USER
	sudo rmmod uvcvideo
	sudo modprobe -r uvcvideo
	sudo modprobe uvcvideo
	mkdir -p ~/.config/systemd/user
	ln -sf ~/arch-setup/config/terminal/ssh-agent.service ~/.config/systemd/user/ssh-agent.service
	ln -sf ~/arch-setup/config/terminal/ssh-add.service ~/.config/systemd/user/ssh-add.service
	ln -sf ~/arch-setup/config/terminal/.profile ~/.profile
	systemctl --user daemon-reexec
	systemctl --user daemon-reload
	systemctl --user enable --now ssh-agent.service
	systemctl --user enable --now ssh-add.service
	git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
	read -p "insira o email para a ssh" email
	ssh-keygen -t ed25519 -C "$email"
	cat ~/.ssh/id_ed25519.pub
	echo "Copie o resultado anterior e cole em: https://github.com/settings/ssh/new"
	eval "$(ssh-agent -s)"
	chmod 600 ~/.ssh/id_ed25519
	ssh-add ~/.ssh/id_ed25519
	
