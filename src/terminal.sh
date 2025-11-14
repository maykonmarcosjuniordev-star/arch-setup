mkdir -p ~/.ssh
function create_symlinks() {
	if [ ! -f ~/.ssh/id_rsa ]; then
		echo "moving ssh keys"
		mv ~/arch-setup/tmp/id_rsa* ~/.ssh/
		chmod 700 ~/.ssh/
		chmod 600 ~/.ssh/id_*
		chmod 644 ~/.ssh/id_*.pub
		chown -R $(whoami):$(whoami) ~/.ssh
		chown -R $(whoami):$(whoami) ~/.ssh/id*
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa
	fi
	mkdir -p ~/.config
	ln -sfn ~/arch-setup/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sfn ~/arch-setup/config/terminal/.bash_profile ~/.bash_profile
	ln -sfn ~/arch-setup/config/terminal/.profile ~/.profile
	ln -sfn ~/arch-setup/config/terminal/.bashrc ~/.bashrc
	ln -sfn ~/arch-setup/config/terminal/starship.toml ~/.config/starship.toml
}

function gen_key() {
	read -p "insira o email para a ssh rsa" email
	ssh-keygen -t rsa -b 4096 -C "$email"
	cat ~/.ssh/id_rsa.pub
	read -p "Copie o resultado anterior e cole em: https://github.com/settings/ssh/new"
	chmod 700 ~/.ssh/
	chmod 600 ~/.ssh/id_*
	chmod 644 ~/.ssh/id_*.pub
	chown -R $(whoami):$(whoami) ~/.ssh
	chown -R $(whoami):$(whoami) ~/.ssh/id*
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
}

case $1 in
	"symlinks")
		create_symlinks
		;;
	"genkey")
		gen_key
		;;
	*)
		echo "Usage: $0 {symlinks|genkey}"
		exit
esac