#!/bin/bash
set -e
hostname=$1
user=$2

loadkeys br-abnt2
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "$hostname" > /etc/hostname
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

systemctl enable NetworkManager systemd-timesyncd

bootctl install

uuid=$(blkid -s UUID -o value /dev/$(findmnt -no SOURCE /))
cat > /boot/loader/entries/arch.conf <<EOF
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=$uuid rw
EOF

useradd -m -G wheel -s /bin/bash "$user"
echo "Set password for $user"
passwd "$user"
echo "Set password for root"
passwd

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers