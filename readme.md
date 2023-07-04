
# Dotfiles
This repo stores all of my dotfiles.

## Initial Install Procedure
```bash
fdisk -l
fdisk /dev/sda

# TODO: need to automate disk partitioning in some way

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
pacman -S vim

# TODO: store local.gen in dotfiles
vim /etc/locale.gen
locale-gen
# TODO: store /etc/hostname in dotfiles
vim /etc/hostname
# TODO: store /etc/hosts in dotfiles
vim /etc/hosts

passwd
useradd -m fei
useradd -m andrew
passwd andrew
passwd fei 
usermod -ag wheel,audio,video,optical,storage andrew
usermod -ag wheel,audio,video,optical,storage fei 

pacman -S sudo
EDITOR=vim visudo

pacman -S grub
pacman -S efibootmgr dosfstools os-prober mtools
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootload-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager
systemctl envable NetworkManager

exit
umount /mnt
reboot
```

