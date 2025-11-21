
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' format 'Completing by %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p %l: Hit TAB for more, or the character to insert %s
zstyle ':completion:*' matcher-list '+' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 5 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' prompt '%e errors (supposedly) found. Would you like to corect them? '
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/maykon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.sh_history
HISTSIZE=10000
SAVEHIST=500
setopt autocd extendedglob notify
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

# The following line were manually added by the user
export PATH="$HOME/.local/bin:$PATH"

if [ -f ~/.zsh_profile ]; then
        source ~/.zsh_profile
fi
if [ -f ~/.aliases ]; then
        source ~/.aliases
fi

eval "$(zoxide init --cmd cd zsh)"
# End of lines manually added by the user