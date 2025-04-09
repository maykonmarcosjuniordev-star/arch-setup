all:
	dconf load / < ~/arch-setup/config/dconf/user.txt
	mkdir -p ~/.config/environment.d/
	cp ~/arch-setup/config/environment.d/ibus.conf ~/.config/environment.d/ibus.conf
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
	export INPUT_METHOD=ibus

dump:
	dconf dump / > ~/arch-setup/config/dconf/user.txt

reset:
	dconf reset -f /org/gnome/
/
