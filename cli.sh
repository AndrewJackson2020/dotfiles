#!/usr/bin/env bash


set -e


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
    pacstrap /mnt base linux linux-firmware
    genfstab -U /mnt >> /mnt/etc/fstab
    
    arch-chroot /mnt
}


initial_setup_2 () {
    
    /tmp/dotfiles/cli.sh install
    cd /tmp/dotfiles    
    sudo stow -d ./system/ -t / . --verbose

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

}

stow_config_files () {
    echo "stowing home config files"
    stow -d ./home -t ~/ . --verbose
    echo "home config files stowed"
    echo "stowing systemm config files"
    sudo stow -d ./system/ -t / . --verbose
    echo "systemm config files stowed"
}


unstow_config_files () {
    echo "unstowing home config files"
    stow -d ./home -t ~/ -D . --verbose
    echo "home config files unstowed"
    echo "unstowing system config files"
    sudo stow -d ./ -t / -D . --verbose
    echo "sysemm config files unstowed"
}


install_packages () {
    echo "installing packages"
    
    pacman -Syu --noconfirm  \
    	reflector \
	xorg-server \
	xorg-xinit \
	xorg \
	i3 \
	nitrogen \
	picom \
	terminator \
	firefox \
	vim \
	emacs \
	xf86-video-fbdev \
	dmenu \
	libreoffice-fresh \
	pulseaudio \
	stow \
	steam \
	gimp \
	docker \
	nodejs \
	terraform \
	fortune-mod \
	r \
	rust \
	qbittorrent \
	bitwarden \
	cowsay \
	code \
	virtualbox \
	sudo \
	grub \
	efibootmgr \
	dosfstools \
	os-prober \
	mtools \
	networkmanager
	    
    # TODO Need to get AUR working for davinci-resolve
	    
    echo "packages installed"
}


action=$1

if [ "$action" = "stow" ]
then
    stow_config_files
fi

if [ "$action" = "unstow" ]
then
    unstow_config_files
fi

if [ "$action" = "install" ]
then
    install_packages
fi
