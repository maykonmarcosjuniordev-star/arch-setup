#!/bin/bash

# Caminhos
BRAVE_CONFIG_DIR="$HOME/.config/BraveSoftware/Brave-Browser"
BACKUP_DIR="$HOME/arch-setup/config/brave"

# Backup
backup() {
    echo "📦 Iniciando backup de configurações do Brave..."

    mkdir -p "$BACKUP_DIR"
    cp "$BRAVE_CONFIG_DIR/Preferences" "$BACKUP_DIR/" 2>/dev/null

    echo "✅ Backup completo em: $BACKUP_DIR/Preferences"
}

# Restauração
restore() {
    echo "♻️ Restaurando configurações do Brave..."

    cp "$BACKUP_DIR/Preferences" "$BRAVE_CONFIG_DIR/" 2>/dev/null

    echo "✅ Restauração concluída."
}

# Ajuda
usage() {
    echo "Uso: $0 {backup|restore|link}"
    echo ""
    echo "  backup   - Faz backup das configurações"
    echo "  restore  - Restaura as configurações"
}

# Executar
case "$1" in
    backup)
        backup
        ;;
    restore)
        restore
        ;;
    *)
        usage
        ;;
esac
