#!/usr/bin/env bash


set -e


source ./install_cli_source.sh


help () {

    cat << EOF
Available Commands:
    install
EOF
}


cli (){
	case $1 in
		"install")
			initial_setup
			;;
		"-h" | "--help")
			help
			;;
		*)
			echo "Command '$1' not Available"
			help
			;;
		esac
}

cli $@

