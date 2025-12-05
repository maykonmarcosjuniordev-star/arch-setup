#!/bin/bash
set -e

echo "=== Ativando conexão de rede ==="
bash ~/arch-setup/src/network.sh

# Double-check we have connectivity before continuing
if ! ping -c1 archlinux.org &>/dev/null; then
  echo "Sem conexão à Internet. Abortando instalação."
  exit 1
fi

echo "=== Arch Linux Installer ==="
echo "Discos disponíveis:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

# read -p "Nome do disco (default: nvme0n1): " disk
disk=$(lsblk -dn -o NAME,TYPE | awk '$2=="disk"{print $1; exit}' | tr -d ' \t\n\r')

# If NVMe, use p; otherwise, no p
if [[ "$disk" == *"nvme"* ]]; then
    P="p"
else
    P=""
fi

read -p "Partição EFI (default: ${disk}${P}1): " part_fat
part_fat=${part_fat:-${disk}${P}1}

read -p "Partição swap (default: ${disk}${P}2): " part_swap
part_swap=${part_swap:-${disk}${P}2}

read -p "Partição raiz (default: ${disk}${P}3): " part_data
part_data=${part_data:-${disk}${P}3}

echo "Usando partições: /dev/$part_fat (EFI), /dev/$part_data (raiz), /dev/$part_swap (swap)"

read -p "Hostname (default: arch): " hostname
hostname=${hostname:-arch}

read -p "Usuário (default: user): " user
user=${user:-user}


# Partition the disk
sgdisk -Z "/dev/$disk"  # zap all on disk
sgdisk -n 1:0:+1G   -t 1:ef00 "/dev/$disk"
sgdisk -n 2:0:+8G   -t 2:8200 "/dev/$disk"    # swap 8 GB
sgdisk -n 3:0:0     -t 3:8304 "/dev/$disk"   # root on rest of disk 

echo "=== Verificando partições montadas ==="
for dev in "/dev/$part_fat" "/dev/$part_data" "/dev/$part_swap"; do
  mntpoints=$(findmnt -n -o TARGET -S "$dev" || true)
  if [ -n "$mntpoints" ]; then
    echo "Desmontando $dev de: $mntpoints"
    for mp in $mntpoints; do
      umount -l "$mp" || { echo "Falha ao desmontar $mp"; exit 1; }
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
pacstrap -K /mnt base linux linux-firmware networkmanager sudo efibootmgr

echo "=== Gerando fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "=== Copiando script de configuração ==="
cat > /mnt/root/setup_inside_chroot.sh <<'EOF'
#!/bin/bash
set -e

hostname=$1
user=$2
root_part=$3

# Detect disk name (strip partition suffix)
# Works for both /dev/sda2 -> /dev/sda and /dev/nvme0n1p2 -> /dev/nvme0n1
root_disk=$(lsblk -no pkname /dev/$root_part)
root_disk="/dev/$root_disk"

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

echo "=== Atualizando mirrorlist ==="
pacman -Syy
pacman -Sy --noconfirm reflector || pacman -S --noconfirm reflector
reflector --country Brazil,Argentina,Chile --age 12 --sort rate \
  --save /etc/pacman.d/mirrorlist

echo "Instalando pacotes adicionais..."
pacman -Syu --noconfirm grub efibootmgr git base-devel pacman-contrib

echo "Instalando bootloader..."
echo "=== Instalando GRUB ==="
if [ -d /sys/firmware/efi ]; then
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  mkdir -p /boot/EFI/BOOT
  cp /boot/EFI/GRUB/grubx64.efi /boot/EFI/BOOT/BOOTX64.EFI 2>/dev/null || true
  echo "Adicionando entrada EFI..."
  efibootmgr --create --disk "$root_disk" --part 1 \
    --label "Arch Linux" --loader '\EFI\GRUB\grubx64.efi' || \
    echo "⚠️  efibootmgr falhou (firmware bloqueou gravação), fallback pronto."
else
  grub-install --target=i386-pc "$root_disk"
fi
grub-mkconfig -o /boot/grub/grub.cfg

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