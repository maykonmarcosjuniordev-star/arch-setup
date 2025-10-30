#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
eval "$(starship init bash)"
# Início do ssh-agent ao logar na sessão gráfica
ssh-add -q ~/.ssh/id_rsa
ssh-add -q ~/.ssh/dev_key
ssh-add -q ~/.ssh/arch/arch
eval "$(ssh-agent -s)" >/dev/null 2>&1
