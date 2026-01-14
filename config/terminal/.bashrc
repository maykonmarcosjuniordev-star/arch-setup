#
# ~/.bashrc
#

export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [ -f ~/.profile ]; then
        source ~/.profile
fi
if [ -f ~/.bash_profile ]; then
        source ~/.bash_profile
fi
if [ -f ~/.aliases ]; then
        source ~/.aliases
fi