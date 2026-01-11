mkdir -p ~/.ssh
function create_symlinks() {
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
	# git credentials, if isn't already present, create
	if [ ! -f ~/arch-setup/credentials/git-credentials ]; then
		mkdir -p ~/arch-setup/credentials
		touch ~/arch-setup/credentials/git-credentials
	fi
	ln -sfn ~/arch-setup/credentials/git-credentials ~/.git-credentials
}

function set_git() {
	# Set identification from install inputs
	read -p "Enter your git user.name (leave blank to skip): " USER_NAME
	if [[ -n "${USER_NAME//[[:space:]]/}" ]]; then
		git config --global user.name "$USER_NAME"
	fi
	read -p "Enter your git user.email (leave blank to skip): " USER_EMAIL
	if [[ -n "${USER_EMAIL//[[:space:]]/}" ]]; then
		git config --global user.email "$USER_EMAIL"
	fi
	chmod 700 ~/.ssh/
	chown -R $(whoami):$(whoami) ~/.ssh
	if [ (! -f ~/.ssh/id_rsa) && (-f ~/arch-setup/credentials/id_rsa) ]; then
		echo "moving ssh keys"
		mv ~/arch-setup/credentials/id_rsa* ~/.ssh/
		chmod 600 ~/.ssh/id_*
		chmod 644 ~/.ssh/id_*.pub
		chown -R $(whoami):$(whoami) ~/.ssh/id*
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa
	fi
	git remote set-url origin git@github.com:maykon-marcos-jr/arch-setup
	echo "installing and configuring git lfs"
	# import gpg key for git lfs
	echo "importing gpg key for git lfs"
	gpg --keyserver hkps://keys.openpgp.org --recv-keys 14F26682D0916CDD81E37B6D61B7B526D98F0353
	# git lfs install
	# track the problematic asset paths with LFS and commit .gitattributes
	# git lfs track "icons/*" "wallpapers/*"
	# git add .gitattributes
	# git commit -m "Track icons and wallpapers with Git LFS"
	### rewrite history converting existing files into LFS objects across all refs
	# git lfs migrate import --include="icons/*,wallpapers/*" --everything
	# git lfs pull
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
	"set_git")
		set_git
		;;
	"genkey")
		gen_key
		;;
	*)
		echo "Usage: $0 {symlinks|set_git|genkey}"
		exit
esac