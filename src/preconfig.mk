all:
	gpg --keyserver hkps://keys.openpgp.org --recv-keys 14F26682D0916CDD81E37B6D61B7B526D98F0353
	chmod +x config/patch-notion-enhanced.linux.sh
