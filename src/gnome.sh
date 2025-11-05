#!/bin/bash

# Functions to apply, dump, and reset GNOME settings using dconf
function apply() {
	yay -Sy --needed --noconfirm - < apps/gnome.list
	sudo systemctl enable gdm
	dconf load / < ~/arch-setup/config/dconf/user.txt
}

function dump() {
	dconf dump / > ~/arch-setup/gnome/dconf/user.txt
}

function reset() {
	dconf reset -f /org/gnome/
}

case $1 in
	apply)
		apply
		;;
	dump)
		dump
		;;
	reset)
		reset
		;;
	*)
		echo "Usage: $0 {apply|dump|reset}"
		exit 1
		;;
esac
