all:
	mkdir -p ~/.config/waybar
	mkdir -p /etc/xdg/waybar
	sudo ln -sf "$(pwd)"/config/waybar/config.jsonc /etc/xdg/waybar/config.jsonc
	sudo ln -sf "$(pwd)"/config/waybar/style.css /etc/xdg/waybar/style.css
	sudo ln -sf "$(pwd)"/config/hypr/hyprlux.toml /etc/hyprlux/config.toml
	sudo ln -sf "$(pwd)"/config/hypr/hyprland.conf /etc/hypr/hyprland.conf
	sudo ln -sf "$(pwd)"/config/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
