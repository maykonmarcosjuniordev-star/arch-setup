#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# Início do ssh-agent ao logar na sessão gráfica
if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null &
        sleep 1  # dá tempo pro agente iniciar
    fi
    ssh-add ~/.ssh/main/id_ed25519 2>/dev/null
    ssh-add ~/.ssh/ufsc/id_ed25519 2>/dev/null
fi
