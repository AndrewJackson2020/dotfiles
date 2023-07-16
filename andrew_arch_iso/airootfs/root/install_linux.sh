

initial_setup () {
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
    pacstrap /mnt \
	base \
	linux \
	linux-firmware \
	networkmanager \
	grub \
	sudo \
	nano \
	vim \
	efibootmgr \
	dosfstools \
	os-prober \
	mtools \
	git \
	stow
    genfstab -U /mnt >> /mnt/etc/fstab
    
    arch-chroot /mnt << EOF

    ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
    hwclock --systohc

    # TODO: populate /etc/skel/ before adding users
    # TODO: Turn into loop 

    useradd -m fei
    useradd -m andrew
    useradd -m bun 
    useradd -m silas 

    echo "andrew:andrew" | chpasswd
    echo "fei:fei" | chpasswd
    echo "bun:bun" | chpasswd
    echo "silas:silas" | chpasswd

    usermod -aG wheel,audio,video,optical,storage andrew
    usermod -aG wheel,audio,video,optical,storage fei 
    usermod -aG wheel,audio,video,optical,storage bun 
    usermod -aG wheel,audio,video,optical,storage silas 
    
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

initial_setup
