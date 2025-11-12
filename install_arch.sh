#!/bin/bash
set -e

read -p "Disk (e.g. nvme0n1): " disk
read -p "Boot partition (e.g. nvme0n1p1): " part_fat
read -p "Root partition (e.g. nvme0n1p2): " part_data
read -p "Swap partition (e.g. nvme0n1p3): " part_swap
read -p "Hostname: " hostname
read -p "User: " user

echo "Formating partitions..."
mkfs.fat -F32 "/dev/$part_fat"
mkfs.ext4 "/dev/$part_data"
mkswap "/dev/$part_swap"

mount "/dev/$part_data" /mnt
mkdir -p /mnt/boot
mount "/dev/$part_fat" /mnt/boot
swapon "/dev/$part_swap"

echo "Installing base system..."
pacstrap -K /mnt $(cat apps/pacstrap.list)

genfstab -U /mnt >> /mnt/etc/fstab

cp setup_inside_chroot.sh /mnt/root/
arch-chroot /mnt /root/setup_inside_chroot.sh "$hostname" "$user"
umount -R /mnt
reboot