#!/usr/bin/env bash

set -e

reflector \
	--verbose \
	--country 'United States' \
	-l 5 \
	--sort rate \
	--save /etc/pacman.d/mirrorlist

pacman-key --init
pacman-key --populate archlinux
pacman --noconfirm -Syu
pacman --noconfirm -Sy archlinux-keyring

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

mkdir /etc/skel/repos/
cd /etc/skel/repos
git clone https://github.com/CommanderKeynes/dotfiles.git
cd /etc/skel/repos/dotfiles    
stow -d ./home/ -t / . --adopt --verbose
git reset --hard
stow -d ./home/ -t / . --verbose

echo "root:root" | chpasswd
for new_user in fei andrew bun silas
do
	useradd -m $new_user
	echo "$new_user:$new_user" | chpasswd
	usermod -aG wheel,audio,video,optical,storage $new_user 
done

mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

mkdir /root/repos
cd /root/repos
git clone https://github.com/CommanderKeynes/dotfiles.git
cd /root/repos/dotfiles    
stow -d ./system/ -t / . --adopt --verbose
git reset --hard
stow -d ./system/ -t / . --verbose

pacman --noconfirm - < /root/package_list	

locale-gen
