

$env:Path += ';C:\Program Files\Oracle\VirtualBox'


function setup_vm {

    VBoxManage createvm `
        --name archvm `
        --ostype Arch_64 `
        --register
    VBoxManage modifyvm archvm `
        --firmware efi
    VBoxManage modifyvm archvm `
        --memory 8000
    VBoxManage createhd `
        --filename `pwd`/archvm/archvm_DISK.vdi `
        --size 80000 `
        --format VDI
    VBoxManage storagectl archvm `
        --name "SATA Controller" `
        --add sata `
        --controller IntelAhci
    VBoxManage storageattach archvm `
        --storagectl "SATA Controller" `
        --port 0 `
        --device 0 `
        --type hdd `
        --medium  `pwd`/archvm/archvm_DISK.vdi
    VBoxManage storagectl archvm `
        --name "IDE Controller" `
        --add ide `
        --controller PIIX4 
    VBoxManage storageattach archvm `
        --storagectl "IDE Controller" `
        --port 1 `
        --device 0 `
        --type dvddrive `
        --medium C:\Users\spike\Downloads\archlinux-2023.11.01-x86_64.iso
        # --medium ./out/andrew_archlinux-2023.07.14-x86_64.iso
    VBoxManage modifyvm archvm `
        --boot1 dvd `
        --boot2 disk `
        --boot3 none `
        --boot4 none 
    VBoxManage modifyvm archvm `
        --nic1 nat
    VBoxManage modifyvm archvm `
        --natpf1 "guestssh,tcp,,2222,,22"
    VBoxManage modifyvm archvm `
        --natpf1 "guestrdp,tcp,,4000,,3389"
    VBoxManage startvm archvm `
        --type headless

}

function detach_usb_from_vm {

    # TODO Command does not work is Powershell
    # VBoxManage shutdown archvm

    # TODO Below command does not work in powershell
    # VBoxManage modifyvm archvm `
    #     --boot1 disk `
    #     --boot2 dvd `
    #     --boot3 none `
    #     --boot4 none

    VBoxManage startvm archvm `
        --type headless
}


function destroy_vm {
    Remove-Item `pwd`/archvm/archvm_DISK.vdi 
    VBoxManage shutdown archvm
    VBoxManage unregistervm archvm --delete
}

function ssh_into_vm {
    Remove-Item --force ./.ssh/known_hosts
    scp -r `
        -P 2222 `
        ./archinstall/* `
        root@127.0.0.1:/root/
    ssh -p 2222 root@127.0.0.1
}