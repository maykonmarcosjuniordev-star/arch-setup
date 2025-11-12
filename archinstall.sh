#!/bin/bash
set -e

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

read -p "Hostname (default: archlinux): " hostname
hostname=${hostname:-archlinux}

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
pacstrap -K /mnt base linux linux-firmware networkmanager vim

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

echo "Instalando bootloader..."
bootctl install

root_uuid=$(blkid -s UUID -o value $(findmnt -no SOURCE /))
cat > /boot/loader/entries/arch.conf <<EOC
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=$root_uuid rw
EOC

echo "Criando usuário $user..."
useradd -m -G wheel -s /bin/bash "$user"
echo "Defina a senha do usuário $user:"
passwd "$user"
echo "Defina a senha do root:"
passwd

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "Configuração dentro do sistema concluída!"
EOF

chmod +x /mnt/root/setup_inside_chroot.sh

echo "=== Entrando no chroot ==="
arch-chroot /mnt /root/setup_inside_chroot.sh "$hostname" "$user"

echo "=== Finalizando instalação ==="
umount -R /mnt
reboot