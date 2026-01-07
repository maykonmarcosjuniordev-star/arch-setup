#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [ -f ~/.bash_profile ]; then
        source ~/.bash_profile
fi
if [ -f ~/.aliases ]; then
        source ~/.aliases
fi
eval "$(zoxide init bash)"