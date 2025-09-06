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
	systemctl --user enable --now pipewire pipewire-pulse wireplumber
	systemctl enable bluetooth.service
	sudo usermod -aG video $USER
	sudo rmmod uvcvideo
	sudo modprobe -r uvcvideo
	sudo modprobe uvcvideo
	git remote set-url origin git@github.com:maykonmjunior/arch-setup.git
	
