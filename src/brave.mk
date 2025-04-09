# https://brave.com/linux/
all:
	bash ~/arch-setup/config/brave/backup.sh link

backup:
	bash ~/arch-setup/config/brave/backup.sh backup

restore:
	bash ~/arch-setup/config/brave/backup.sh restore
