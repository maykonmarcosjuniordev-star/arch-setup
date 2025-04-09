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
        echo "❌ Nome do perfil não pode ser vazio."
        exit 1
    fi
    echo "🗂️  Backup do perfil: $profile"
    mkdir -p "$BACKUP_DIR/$profile"
    cp "$BRAVE_CONFIG_DIR/$profile/Preferences" "$BACKUP_DIR/$profile/" 2>/dev/null
    cp "$BRAVE_CONFIG_DIR/$profile/Secure Preferences" "$BACKUP_DIR/$profile/" 2>/dev/null
    cp "$BRAVE_CONFIG_DIR/Local State" "$BACKUP_DIR/" 2>/dev/null

    echo "✅ Backup completo em: $BACKUP_DIR/$profile/"
}

# Restauração
restore() {
    echo "♻️ Restaurando configurações do Brave..."

    read -p "Insira o nome do perfil (Default, Profile 1, etc): " profile
    if [ -z "$profile" ]; then
        echo "❌ Nome do perfil não pode ser vazio."
        exit 1
    fi
    echo "🗂️  Restaurando perfil: $profile"

    cp "$BACKUP_DIR/$profile/Preferences" "$BRAVE_CONFIG_DIR/$profile/" 2>/dev/null
    cp "$BACKUP_DIR/$profile/Secure Preferences" "$BRAVE_CONFIG_DIR/$profile/" 2>/dev/null
    cp "$BACKUP_DIR/Local State" "$BRAVE_CONFIG_DIR/" 2>/dev/null

    echo "✅ Restauração concluída."
}

# Mover e criar symlinks
link_profiles() {
    echo "🔗 Movendo configs para $BACKUP_DIR e criando links simbólicos..."

    mkdir -p "$BACKUP_DIR"

    read -p "Insira o nome do perfil (Default, Profile 1, etc): " profile
    if [ -z "$profile" ]; then
        echo "❌ Nome do perfil não pode ser vazio."
        exit 1
    fi
    echo "🗂️  Processando perfil: $profile"

    mkdir -p "$BACKUP_DIR/$profile"

    # Move arquivos
    for file in "Preferences" "Secure Preferences"; do
        if [ -f "$BRAVE_CONFIG_DIR/$profile/$file" ]; then
            mv "$BRAVE_CONFIG_DIR/$profile/$file" "$BACKUP_DIR/$profile/"
            ln -s "$BACKUP_DIR/$profile/$file" "$BRAVE_CONFIG_DIR/$profile/$file"
            echo "  ✅ $file linkado"
        fi
    done

    # Local State
    if [ -f "$BRAVE_CONFIG_DIR/Local State" ]; then
        mv "$BRAVE_CONFIG_DIR/Local State" "$BACKUP_DIR/"
        ln -s "$BACKUP_DIR/Local State" "$BRAVE_CONFIG_DIR/Local State"
        echo "  ✅ Local State linkado"
    fi

    echo "🔗 Symlinks criados com sucesso."
}

# Ajuda
usage() {
    echo "Uso: $0 {backup|restore|link}"
    echo ""
    echo "  backup   - Faz backup das configurações"
    echo "  restore  - Restaura as configurações"
    echo "  link     - Move configurações para outro diretório e cria links simbólicos"
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
