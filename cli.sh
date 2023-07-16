#!/usr/bin/env bash

set -e

source ./cli_source.sh


if [ "$1" = "--help" ]
then
    echo "Help for cli"

elif [ "$2" = "vm" ]
then 
	if [ "$2" = "--help" ]
	    echo "Help for VM CLI"
	elif [ "$2" = "create" ]
	then 
	    setup_vm

	elif [ "$2" = "ssh" ]
	then
	    rm --force /home/andrew/.ssh/known_hosts
	    scp  \
		-P 2222 \
		./andrew_arch_iso/airootfs/root/install_linux.sh \
		root@127.0.0.1:/root/
	    scp -r \
		-P 2222 \
		./andrew_arch_iso/airootfs/root/archinstall_installer/archinstall_installer \
		root@127.0.0.1:/root/archinstall_installer
	    ssh -p 2222 root@127.0.0.1


	elif [ "$2" = "detach_boot" ]
	then
	    detach_usb_from_vm 

	elif [ "$2" = "destroy" ]
	then
	    rm `pwd`/archvm/archvm_DISK.vdi 
	    VBoxManage shutdown archvm
	    VBoxManage unregistervm archvm --delete
	else
	    echo "Command $2 not recognized."
	fi

elif [ "$1" = "build_iso" ]
then 
    mkarchiso -v -w /tmp/archiso-tmp/ ./archlivve/

elif [ "$1" = "stow" ]
then
    stow_config_files

elif [ "$1" = "unstow" ]
then
    unstow_config_files

elif [ "$1" = "install" ]
then
    install_packages
else 
    echo "Command $1 not recognized"
fi

