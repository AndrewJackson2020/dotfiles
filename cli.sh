#!/usr/bin/env bash

set -e

source ./cli_source.sh


vm_help () {

	cat << EOF
		Available Commands:
			create
			ssh
			detach_boot
			destroy		
EOF
}


vm_commands () {

	case $1 in 
    	"--help" | "-h")
			vm_help
			;;
		"create")
			setup_vm
		
		"ssh")
			rm --force /home/andrew/.ssh/known_hosts
			scp  \
				-P 2222 \
				./andrew_arch_iso/airootfs/root/install_cli.sh \
				root@127.0.0.1:/root/
			scp  \
				-P 2222 \
				./andrew_arch_iso/airootfs/root/install_cli_source.sh \
				root@127.0.0.1:/root/
			scp  \
				-P 2222 \
				./andrew_arch_iso/airootfs/root/package_list \
				root@127.0.0.1:/root/
			scp -r \
				-P 2222 \
				./andrew_arch_iso/airootfs/root/archinstall_installer \
				root@127.0.0.1:/root/archinstall_installer
				ssh -p 2222 root@127.0.0.1
			;;

		"detach_boot")
			detach_usb_from_vm 
			;;
		"destroy")
			rm `pwd`/archvm/archvm_DISK.vdi 
			VBoxManage shutdown archvm
			VBoxManage unregistervm archvm --delete
			;;
		"*")
			echo "Command $2 not recognized."
		esac
}


main_help () {
	cat << EOF
		Available Commands:
			vm
			build_iso
			stow
			unstow	
			install
EOF

}


main_commands () {
	case $1 in 
		"--help" | "-h")
			main_help
			;;
		"vm")
			vm_commands "${@:2}"
			;;
		
		"build_iso")
			mkarchiso -v -w /tmp/archiso-tmp/ ./archlivve/
			;;

		"stow")
			stow_config_files
			;;
		"unstow")
			unstow_config_files
			;;
		"install")
			install_packages
			;;
		*)
			echo "Command $1 not recognized"
			;;
	esac	
}


main_commands "$@"

