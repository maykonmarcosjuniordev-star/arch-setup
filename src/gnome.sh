#!/bin/bash

# Functions to apply, dump, and reset GNOME settings using dconf
function apply() {
	yay -Sy --needed --noconfirm - < ~/arch-setup/apps/gnome.list
}

function load() {
	dconf load / < ~/arch-setup/config/dconf/user.txt
}

function dump() {
	dconf dump / > ~/arch-setup/config/dconf/user.txt
}

function reset() {
	dconf reset -f /org/gnome/
}

case $1 in
	apply)
		apply
		;;
	load)
		load
		;;
	dump)
		dump
		;;
	reset)
		reset
		;;
	*)
		echo "Usage: $0 {apply|load|dump|reset}"
		exit 1
		;;
esac
