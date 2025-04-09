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
	systemctl --user daemon-reexec
	systemctl --user daemon-reload
	systemctl --user enable --now ssh-agent.service
	systemctl --user enable --now ssh-add.service
