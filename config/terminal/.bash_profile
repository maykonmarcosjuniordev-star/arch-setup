#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
# Início do ssh-agent ao logar na sessão gráfica
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add -q ~/.ssh/id_rsa
eval "$(starship init bash)"