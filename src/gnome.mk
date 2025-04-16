all:
	dconf load / < ~/arch-setup/config/dconf/user.txt

dump:
	dconf dump / > ~/arch-setup/config/dconf/user.txt

reset:
	dconf reset -f /org/gnome/
