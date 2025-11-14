#!/bin/bash
set -e

# Start NetworkManager in the live environment
systemctl start NetworkManager || true

# Check connectivity first (for wired setups)
if ping -c1 archlinux.org &>/dev/null; then
  echo "Conexão detectada (Ethernet)."
else
  echo "Nenhuma conexão detectada."
  echo "Dispositivos Wi-Fi disponíveis:"
  nmcli device | grep wifi || true

  read -p "Deseja conectar via Wi-Fi? (s/N): " wifi_choice
  if [[ $wifi_choice =~ ^[SsYy]$ ]]; then
    read -p "SSID (nome da rede): " ssid
    read -p "Senha Wi-Fi: " -s wifi_pass
    echo
    echo "Conectando a '$ssid'..."
    nmcli device wifi connect "$ssid" password "$wifi_pass" || {
      echo "Falha ao conectar ao Wi-Fi. Verifique SSID/senha."
      exit 1
    }
  else
    echo "Prosseguindo sem Wi-Fi."
  fi
fi