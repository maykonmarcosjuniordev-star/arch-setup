function create_symlinks() {
	ln -sf ~/arch-setup/config/terminal/.bash_aliases ~/.bash_aliases
	ln -sf ~/arch-setup/config/terminal/.bash_profile ~/.bash_profile
	ln -sf ~/arch-setup/config/terminal/.profile ~/.profile
	ln -sf ~/arch-setup/config/terminal/.bashrc ~/.bashrc
	ln -sf ~/arch-setup/config/terminal/starship.toml ~/.config/starship.toml
}

function gen_key() {
	read -p "insira o email (e nomeie) para a ssh" email
	ssh-keygen -t rsa -b 4096 -C "$email"
	cat ~/.ssh/*.pub
	read -p "Copie o resultado anterior e cole em: https://github.com/settings/ssh/new"
	read -p "insira o email para a ssh rsa" email
	ssh-keygen -t rsa -b 4096 -C "$email"
	cat ~/.ssh/id_rsa.pub
	read -p "Copie o resultado anterior e cole em: https://github.com/settings/ssh/new"
	chmod 600 ~/.ssh/id_ed25519
	chmod 600 ~/.ssh/id_rsa
	ssh-add ~/.ssh/id_ed25519
	ssh-add ~/.ssh/id_rsa
	eval "$(ssh-agent -s)"
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
