#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
eval "$(starship init bash)"
# Início do ssh-agent ao logar na sessão gráfica
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/dev_key
ssh-add ~/.ssh/arch/arch
eval "$(ssh-agent -s)"
