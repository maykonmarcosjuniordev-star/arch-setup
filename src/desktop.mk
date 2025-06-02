all:
	chmod +x config/notion/patch-notion-enhanced.linux.sh
	sudo ~/arch-setup/config/notion/patch-notion-enhanced.linux.sh
	ln -sf ~/arch-setup/config/notion/.notion-enhancer ~/.notion-enhancer
