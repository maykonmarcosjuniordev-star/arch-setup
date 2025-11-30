mkdir -p ~/.ssh
function create_symlinks() {
	if [ ! -f ~/.ssh/id_rsa ]; then
		echo "moving ssh keys"
		mv ~/arch-setup/credentials/id_rsa* ~/.ssh/
		chmod 700 ~/.ssh/
		chmod 600 ~/.ssh/id_*
		chmod 644 ~/.ssh/id_*.pub
		chown -R $(whoami):$(whoami) ~/.ssh
		chown -R $(whoami):$(whoami) ~/.ssh/id*
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa
	fi
	mkdir -p ~/.config
	# ssh suport
	ln -sfn ~/arch-setup/config/terminal/.profile ~/.profile
	# custom colors
	ln -sfn ~/arch-setup/config/terminal/starship.toml ~/.config/starship.toml
	# bash
	ln -sfn ~/arch-setup/config/terminal/.bashrc ~/
	ln -sfn ~/arch-setup/config/terminal/.aliases ~/
	ln -sfn ~/arch-setup/config/terminal/.bash_profile ~/
	ln -sfn ~/arch-setup/config/terminal/.gitconfig ~/
	# Set identification from install inputs
	read -p "Enter your git user.name (leave blank to skip): " USER_NAME
	if [[ -n "${USER_NAME//[[:space:]]/}" ]]; then
		git config --global user.name "$USER_NAME"
	fi
	read -p "Enter your git user.email (leave blank to skip): " USER_EMAIL
	if [[ -n "${USER_EMAIL//[[:space:]]/}" ]]; then
		git config --global user.email "$USER_EMAIL"
	fi
	# read -p "Do you want to set zsh as default shell? (y/N) " choice
	# if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
	# 	chsh -s $(which zsh)
	# else
	# 	# set default shell to bash
	# 	chsh -s $(which bash)
	# fi
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