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

echo "Installing base system..."
pacstrap -K /mnt $(cat apps/pacstrap.list)

genfstab -U /mnt >> /mnt/etc/fstab

cp setup_inside_chroot.sh /mnt/root/
arch-chroot /mnt /root/setup_inside_chroot.sh "$hostname" "$user"
umount -R /mnt
reboot