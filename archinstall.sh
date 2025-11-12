echo "Formate uma partição FAT32 com 1 GiB para EFI, uma de swap [linux-swap] e o restante para a partição ext4"
fdisk -l "/dev/$disk"

read -p "Insira o nome do disco que será formatado (nvme0n1) " disk
read -p "Insira o nome da partição de boot que será formatada (nvme0n1p1) " part_fat
read -p "Insira o nome da partição de dados que será formatada (nvme0n1p2) " part_data
read -p "Insira o nome da partição de swap (nvme0n1p3) " part_swap
read -p "Insira o nome do host (hostname) " hostname
read -p "Insira o nome do usuário que será criado (user) " user

# Ativação do Pacman
echo "Ativando o Pacman..."
pacman-key --init
pacman-key --populate archlinux
# pacman-key --refresh-keys


# Formatar as Partições
echo "Formatando as partições $part_fat, $part_data e $part_swap..."
mkfs.fat -F32 "/dev/$part_fat"
mkfs.ext4 "/dev/$part_data"
mkswap "/dev/$part_swap"


# Mountagem das Partições
echo "Montando as partições..."
mount "/dev/$part_data" /mnt
mkdir -p /mnt/boot
mount "/dev/$part_fat" /mnt/boot
swapon "/dev/$part_swap"

# Pacotes do Sistema Base
echo "Instalando pacotes do sistema base..."
pacstrap -K /mnt $(cat apps/pacstrap.list)

# Geração do fstab
echo "Gerando o fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Entrada na nova instalação
echo "Entrando na nova instalação..."
arch-chroot /mnt

### Configurações básicas
loadkeys br-abnt2
# Configuração de Timezone
echo "Configuração do Timezone..."
ln -sfn /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
# selecção do hostname
echo "Definindo o hostname como $hostname"
echo $hostname > /etc/hostname
# Adiciona uma linha no fim do texto do arquivo /etc/locale.gen
echo "Configuração de Localização..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Habilitação de Servições
echo "Habilitando NetworkManager e systemd-timesyncd..."
systemctl enable NetworkManager
systemctl enable systemd-timesyncd

# instalação de sistemd-boot
echo "Instalando o systemd-boot..."
bootctl --path=/boot install

# Entrada do sistema
mkdir -p /boot/loader/entries

# Obtenção do UUID do usuário
uuid=$(blkid -s UUID -o value /dev/$part_data)
# Criação do arquivo de configuração do sistema
echo "Criando arquivo de configuração do systemd-boot..."
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=$uuid rw" > /boot/loader/entries/arch.conf


# Criação de Usuário e Senha
echo "Criando usuário $user..."
useradd -m -G wheel -s /bin/bash $user
echo "Criação do usuário $user"
echo "Digite a senha do usuário $user:"
passwd $user
# Criação de Senha do Root
echo "Criando senha do root..."
echo "Digite a senha do root:"
passwd root

# permitir sudo para grupo wheel
EDITOR=tee visudo <<EOF
%wheel ALL=(ALL:ALL) ALL
EOF

# Reiniciar o sistema
exit
umount -R /mnt
reboot
