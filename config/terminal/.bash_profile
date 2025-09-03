#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
eval "$(starship init bash)"
# Início do ssh-agent ao logar na sessão gráfica
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/arch/arch
eval "$(ssh-agent -s)"