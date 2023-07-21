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
	reflector \
		--verbose \
		--country 'United States' \
		-l 5 \
		--sort rate \
		--save /etc/pacman.d/mirrorlist

	pacman-key --init
	pacman-key --populate archlinux

    pacman --noconfirm -Sy archlinux-keyring
	#
    # TODO: Package all packages into dependencies of custom package
    pacstrap /mnt base linux linux-firmware reflector
    genfstab -U /mnt >> /mnt/etc/fstab
   	cp /root/installers/package_list /mnt/root/package_list
	cp /root/installers/chroot_install_script.sh /mnt/root/chroot_install_script.sh
    arch-chroot /mnt "/root/chroot_install_script.sh" 
	
    umount -l /mnt
    reboot
}

