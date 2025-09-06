all:
	dconf load / < ~/arch-setup/config/dconf/user.txt
	systemctl enable gdm

dump:
	dconf dump / > ~/arch-setup/config/dconf/user.txt

reset:
	dconf reset -f /org/gnome/
