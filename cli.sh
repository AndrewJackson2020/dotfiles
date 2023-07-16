#!/usr/bin/env bash

set -e

source ./cli_source.sh


if [ "$1" = "vm" ]
then 
	if [ "$2" = "create" ]
	then 
	    setup_vm
	fi

	if [ "$2" = "ssh" ]
	then
	    rm --force /home/andrew/.ssh/known_hosts
	    scp  -P 2222 ./andrew_arch_iso/airootfs/root/install_linux.sh root@127.0.0.1:/root/
	    scp -r -P 2222 ./andrew_arch_iso/airootfs/root/archinstall_installer/archinstall_installer root@127.0.0.1:/root/archinstall_installer
	    ssh -p 2222 root@127.0.0.1
	fi


	if [ "$2" = "detach_boot" ]
	then
	    detach_usb_from_vm 
	fi


	if [ "$2" = "destroy" ]
	then
	    rm `pwd`/archvm/archvm_DISK.vdi 
	    VBoxManage shutdown archvm
	    VBoxManage unregistervm archvm --delete
	fi

fi

if [ "$1" = "build_iso" ]
then 
    mkarchiso -v -w /tmp/archiso-tmp/ ./archlivve/
fi

if [ "$1" = "stow" ]
then
    stow_config_files
fi

if [ "$1" = "unstow" ]
then
    unstow_config_files
fi

if [ "$1" = "install" ]
then
    install_packages
fi
