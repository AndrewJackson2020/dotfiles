initial_setup () {
    sfdisk /dev/sda << EOF
label: gpt
unit: sectors

1: size=1126400, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B 
2: size=4194304, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
3: type=0FC63DAF-8483-4772-8E79-3D69D8477DE4 
EOF

    # TODO: Prompt for disk to use
    
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
    swapon /dev/sda2
    mkfs.ext4 /dev/sda3
    
    mount /dev/sda3 /mnt
    pacman --noconfirm -Sy archlinux-keyring
    # TODO: Pacakge all pacakges into dependencies of custom package
    pacstrap /mnt ./package_list
    genfstab -U /mnt >> /mnt/etc/fstab
    
    arch-chroot /mnt << EOF

    set -e
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

    locale-gen
EOF
    umount /mnt
    reboot
}
