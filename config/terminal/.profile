export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# Início do ssh-agent ao logar na sessão gráfica
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add -q ~/.ssh/id_rsa