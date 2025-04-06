all:
	dconf load / < ~/arch-setup/config/dconf/user.txt

reset:
	dconf dump / > ~/arch-setup/config/dconf/user.txt
