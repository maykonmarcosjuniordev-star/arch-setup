#!/bin/bash
set -e

echo "=== Ativando conexão de rede ==="
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

# Double-check we have connectivity before continuing
if ! ping -c1 archlinux.org &>/dev/null; then
  echo "Sem conexão à Internet. Abortando instalação."
  exit 1
fi

# Save Wi-Fi connection profile to the new system if one was created
if [ -n "$ssid" ] && nmcli connection show "$ssid" &>/dev/null; then
  mkdir -p /mnt/etc/NetworkManager/system-connections
  cp "/etc/NetworkManager/system-connections/$ssid.nmconnection" \
     "/mnt/etc/NetworkManager/system-connections/" 2>/dev/null || true
  chmod 600 "/mnt/etc/NetworkManager/system-connections/$ssid.nmconnection" 2>/dev/null || true
fi

echo "=== Arch Linux Installer ==="
echo "Discos disponíveis:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

read -p "Nome do disco (default: nvme0n1): " disk
disk=${disk:-nvme0n1}

read -p "Partição EFI (default: ${disk}p1): " part_fat
part_fat=${part_fat:-${disk}p1}

read -p "Partição raiz (default: ${disk}p2): " part_data
part_data=${part_data:-${disk}p2}

read -p "Partição swap (default: ${disk}p3): " part_swap
part_swap=${part_swap:-${disk}p3}

read -p "Hostname (default: arch): " hostname
hostname=${hostname:-arch}

read -p "Usuário (default: user): " user
user=${user:-user}

echo "=== Verificando partições montadas ==="
for dev in "/dev/$part_fat" "/dev/$part_data" "/dev/$part_swap"; do
  mntpoints=$(findmnt -n -o TARGET -S "$dev" || true)
  if [ -n "$mntpoints" ]; then
    echo "Desmontando $dev de: $mntpoints"
    for mp in $mntpoints; do
      umount "$mp" || { echo "Falha ao desmontar $mp"; exit 1; }
    done
  fi
done
if swapon --show=NAME | grep -q "/dev/$part_swap"; then
  echo "Desativando swap em /dev/$part_swap"
  swapoff "/dev/$part_swap"
fi

echo "=== Limpando assinaturas antigas ==="
wipefs -a "/dev/$part_fat" || true
wipefs -a "/dev/$part_data" || true
wipefs -a "/dev/$part_swap" || true

echo "=== Formatando partições ==="
mkfs.fat -F32 "/dev/$part_fat"
mkfs.ext4 -F "/dev/$part_data"
mkswap "/dev/$part_swap"

echo "=== Montando partições ==="
mount "/dev/$part_data" /mnt
mkdir -p /mnt/boot
mount "/dev/$part_fat" /mnt/boot
swapon "/dev/$part_swap"


echo "=== Instalando sistema base ==="
# Pacstrap: base + Linux + firmware + NetworkManager
pacstrap -K /mnt base linux linux-firmware networkmanager vim sudo efibootmgr

echo "=== Gerando fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "=== Copiando script de configuração ==="
cat > /mnt/root/setup_inside_chroot.sh <<'EOF'
#!/bin/bash
set -e

hostname=$1
user=$2

echo "Configurando idioma e fuso horário..."
loadkeys br-abnt2
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "$hostname" > /etc/hostname
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "Ativando serviços..."
systemctl enable NetworkManager
systemctl enable systemd-timesyncd

echo "Instalando pacotes adicionais..."
pacman -Syu --noconfirm grub git base-devel

echo "Instalando bootloader..."
grub-install --target=i386-pc /dev/$root_disk
grub-mkconfig -o /boot/grub/grub.cfg
efibootmgr --create --disk /dev/$disk --part 1 --label "Arch Linux" --loader '\EFI\systemd\systemd-bootx64.efi'

root_uuid=$(blkid -s UUID -o value /dev/$3)
cat > /boot/loader/entries/arch.conf <<EOC
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=$root_uuid rw
EOC

echo "Criando usuário $user..."
if ! id "$user" &>/dev/null; then
  useradd -m -G wheel -s /bin/bash "$user"
fi
echo "Defina a senha do usuário $user:"
passwd "$user"
echo "Defina a senha do root:"
passwd

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

git clone https://github.com/maykonmarcosjuniordev-star/arch-setup "home/$user/arch-setup"

echo "Configuração dentro do sistema concluída!"
EOF

chmod +x /mnt/root/setup_inside_chroot.sh

echo "=== Preparando ambiente chroot ==="
for dir in /dev /dev/pts /proc /sys /run; do
  mount --bind $dir /mnt$dir
done

mount -t efivarfs efivarfs /mnt/sys/firmware/efi/efivars || true

echo "=== Entrando no chroot ==="
# Ensure EFI vars are available for bootctl
if [ -d /sys/firmware/efi/efivars ]; then
  mountpoint -q /sys/firmware/efi/efivars || mount -t efivarfs efivarfs /sys/firmware/efi/efivars
fi
arch-chroot /mnt /root/setup_inside_chroot.sh "$hostname" "$user" "$part_data"

echo "=== Finalizando instalação ==="
echo "=== Saindo do chroot e desmontando partições ==="
umount -l /mnt/sys/firmware/efi/efivars 2>/dev/null || true
for dir in /run /sys /proc /dev/pts /dev; do
  umount -l /mnt$dir 2>/dev/null || true
done
swapoff -a || true
umount -R /mnt || true
reboot