#!/usr/bin/env bash

set -e

source ./cli_source.sh

action=$1

if [ "$action" = "create_vm" ]
then 
    setup_vm
fi

if [ "$action" = "ssh_to_vm" ]
then
    rm --force /home/andrew/.ssh/known_hosts
    scp  -P 2222 ./andrew_arch_iso/airootfs/root/install_linux.sh root@127.0.0.1:/root/
    scp -r -P 2222 ./andrew_arch_iso/airootfs/root/archinstall_installer/install_config root@127.0.0.1:/root/
    scp  -P 2222 ./andrew_arch_iso/airootfs/root/archinstall_installer/install.sh root@127.0.0.1:/root/
    ssh -p 2222 root@127.0.0.1
fi


if [ "$action" = "detach_usb_from_vm" ]
then
    detach_usb_from_vm 
fi


if [ "$action" = "destroy_vm" ]
then
    rm `pwd`/archvm/archvm_DISK.vdi 
    VBoxManage shutdown archvm
    VBoxManage unregistervm archvm --delete
fi

if [ "$action" = "build_iso" ]
then 
    mkarchiso -v -w /tmp/archiso-tmp/ ./archlivve/
fi

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
