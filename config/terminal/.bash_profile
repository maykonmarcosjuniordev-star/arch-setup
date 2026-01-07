#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -f ~/.profile ]; then
        source ~/.profile
fi
eval "$(starship init bash)"