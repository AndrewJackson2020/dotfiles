

detach_usb_from_vm () {
    VBoxManage shutdown archvm
    VBoxManage modifyvm archvm \
        --boot1 disk \
        --boot2 dvd \
        --boot3 none \
        --boot4 none
    VBoxManage startvm archvm \
        --type headless
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
    
    pacman -Syu --noconfirm ./system_installs.txt
	    
    # TODO Need to get AUR working for davinci-resolve
	    
    echo "packages installed"
}


setup_vm () {

    VBoxManage createvm \
        --name archvm \
        --ostype Arch_64 \
        --register
    VBoxManage modifyvm archvm \
        --firmware efi
    VBoxManage modifyvm archvm \
        --memory 8000
    VBoxManage createhd \
        --filename `pwd`/archvm/archvm_DISK.vdi \
        --size 80000 \
        --format VDI
    VBoxManage storagectl archvm \
        --name "SATA Controller" \
        --add sata \
        --controller IntelAhci
    VBoxManage storageattach archvm \
        --storagectl "SATA Controller" \
        --port 0 \
        --device 0 \
        --type hdd \
        --medium  `pwd`/archvm/archvm_DISK.vdi
    VBoxManage storagectl archvm \
        --name "IDE Controller" \
        --add ide \
        --controller PIIX4 
    VBoxManage storageattach archvm \
        --storagectl "IDE Controller" \
        --port 1 \
        --device 0 \
        --type dvddrive \
        --medium ./out/andrew_archlinux-2023.07.14-x86_64.iso
    VBoxManage modifyvm archvm \
        --boot1 dvd \
        --boot2 disk \
        --boot3 none \
        --boot4 none 
    VBoxManage modifyvm archvm \
        --nic1 nat
    VBoxManage modifyvm archvm \
        --natpf1 "guestssh,tcp,,2222,,22"
    VBoxManage startvm archvm \
        --type headless

}
