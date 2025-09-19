all:
	@git clone https://github.com/quickemu-project/quickemu.git
	@yay --needed --noconfirm ventoy-bin qemu-full spice spice-gtk
	@yay --needed --noconfirm wine winetricks wine-gecko wine-mono
	@yay --needed --noconfirm waydroid
	@yay --needed --noconfirm darling-bin
	@yay --needed --noconfirm gnome-boxes-git
	@yay --needed --noconfirm virtualbox-bin
