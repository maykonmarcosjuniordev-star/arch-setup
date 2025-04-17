#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
if [ -f ~/.bash_aliases ]; then
        source ~/.bash_aliases
fi
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
eval "$(ssh-agent -s)" > /dev/null

# Adiciona as duas chaves automaticamente
ssh-add -q ~/.ssh/main/id_ed25519
ssh-add -q ~/.ssh/ufsc/id_ed25519
