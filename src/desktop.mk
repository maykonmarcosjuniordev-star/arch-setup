all:
	systemctl --user daemon-reload
	systemctl --user enable firefox-sync
	systemctl --user start firefox-sync
	systemctl --user enable firefox-sync-cron --now
