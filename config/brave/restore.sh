#!/bin/bash

set -e

BACKUP_DIR=~/arch-setup/config/brave
SOURCE="$BACKUP_DIR/BraveSoftware.tar.gz"
TARGET=~/.config/BraveSoftware/

if [ ! -f "$SOURCE" ]; then
  echo "[!] Backup não encontrado em $SOURCE"
  exit 1
fi

echo "[*] Fechando o Brave (se estiver aberto)..."
pkill brave || true

echo "[*] Removendo configuração atual (se existir)..."
#rm -rf "$TARGET"

echo "[*] Restaurando o backup do Brave..."
mkdir -p "$HOME/.config"
tar -xzf "$SOURCE" -C "$TARGET"

echo "[✔] Restauração concluída!"
