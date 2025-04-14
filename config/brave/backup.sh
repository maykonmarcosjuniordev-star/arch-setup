#!/bin/bash

# Caminhos
BRAVE_CONFIG_DIR="$HOME/.config/BraveSoftware/Brave-Browser"
BACKUP_DIR="$HOME/arch-setup/config/brave"

# Backup
backup() {
    echo "📦 Iniciando backup de configurações do Brave..."

    mkdir -p "$BACKUP_DIR"

    read -p "Insira o nome do perfil (Default, Profile 1, etc): " profile
    if [ -z "$profile" ]; then
        profile="Default"
    fi
    echo "🗂️  Backup do perfil: $profile"
    mkdir -p "$BACKUP_DIR/$profile"
    cp "$BRAVE_CONFIG_DIR/$profile/Preferences" "$BACKUP_DIR/$profile/" 2>/dev/null
    cp "$BRAVE_CONFIG_DIR/Local State" "$BACKUP_DIR/" 2>/dev/null

    echo "✅ Backup completo em: $BACKUP_DIR/$profile/"
}

# Restauração
restore() {
    echo "♻️ Restaurando configurações do Brave..."

    read -p "Insira o nome do perfil (Default, Profile 1, etc): " profile
    if [ -z "$profile" ]; then
        profile="Default"
    fi
    echo "🗂️  Restaurando perfil: $profile"

    cp "$BACKUP_DIR/$profile/Preferences" "$BRAVE_CONFIG_DIR/$profile/" 2>/dev/null
    cp "$BACKUP_DIR/Local State" "$BRAVE_CONFIG_DIR/" 2>/dev/null

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
    link)
        link_profiles
        ;;
    *)
        usage
        ;;
esac
