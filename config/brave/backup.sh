#!/bin/bash

set -e

BACKUP_DIR=~/arch-setup/config/brave
TARGET="$BACKUP_DIR/BraveSoftware.tar.gz"

echo "[*] Fechando o Brave (se estiver aberto)..."
pkill brave || true

echo "[*] Fazendo backup do Brave..."
tar -czf "$TARGET" -C "$HOME/.config/BraveSoftware" Brave-Browser

echo "[✔] Backup salvo em: $TARGET"
