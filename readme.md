
# Dotfiles
This repo stores all of my dotfiles.

## Initial Setup

Initial setup
```bash
sfdisk /dev/sda << EOF
label: gpt
unit: sectors

1: size=1126400, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B 
2: size=4194304, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
3: type=0FC63DAF-8483-4772-8E79-3D69D8477DE4 
EOF

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
```

Run after chrooting into partition
```bash
pacman -S git
cd tmp
git clone https://github.com/CommanderKeynes/dotfiles.git

/tmp/dotfiles/cli.sh install

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

locale-gen

passwd andrew
useradd -m fei
useradd -m andrew
passwd andrew
passwd fei 
usermod -ag wheel,audio,video,optical,storage andrew
usermod -ag wheel,audio,video,optical,storage fei 

EDITOR=vim visudo

mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootload-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

exit
```

Teardown after exiting chroot
```bash
umount /mnt
reboot
```

