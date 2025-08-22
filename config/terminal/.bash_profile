#
# ~/.bash_profile
#

# [[ -f ~/.bashrc ]] && . ~/.bashrc
# Início do ssh-agent ao logar na sessão gráfica
if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null &
        eval "$(ssh-agent -s)"
        sleep 1  # dá tempo pro agente iniciar
    fi
fi