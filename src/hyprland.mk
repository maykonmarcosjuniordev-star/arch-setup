all:
	mkdir -p ~/.config/waybar
	mkdir -p /etc/xdg/waybar
	sudo ln -sf "$(pwd)"/config/waybar/* /etc/xdg/waybar/*
	sudo ln -sf "$(pwd)"/config/hypr/hyprlux.toml /etc/hyprlux/config.toml
