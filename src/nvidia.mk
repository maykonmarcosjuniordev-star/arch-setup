all:
	@echo "installing nvidias drives"
	@yay -Sy --needed --noconfirm nvidia nvidia-prime nvidia-utils
	@echo "replacing binaries in usr/bin/ to run with prime-run"

	@echo "for brave"
	@sudo mv /usr/bin/brave /usr/bin/brave-real
	@echo '#!/bin/bash
exec prime-run /usr/bin/brave-real "$@"' | sudo tee /usr/bin/brave
	@sudo chmod +x /usr/bin/brave

	@echo "for vs-code"
	@sudo mv /usr/bin/code /usr/bin/code-real
	@echo '#!/bin/bash
exec prime-run /usr/bin/code-real "$@"' | sudo tee /usr/bin/code
	@sudo chmod +x /usr/bin/code

	@echo "for firefox"
	@sudo mv /usr/bin/firefox /usr/bin/firefox-real
	@echo '#!/bin/bash
exec prime-run /usr/bin/firefox-real "$@"' | sudo tee /usr/bin/firefox
	@sudo chmod +x /usr/bin/firefox

	@echo "for vlc"
	@sudo mv /usr/bin/vlc /usr/bin/vlc-real
	@echo '#!/bin/bash
exec prime-run /usr/bin/vlc-real "$@"' | sudo tee /usr/bin/vlc
	@sudo chmod +x /usr/bin/vlc
