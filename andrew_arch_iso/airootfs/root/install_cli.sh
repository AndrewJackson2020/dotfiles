#!/usr/bin/env bash
set -e

source ./install_cli_source.sh

if [ "$1" = "install" ]
then
    initial_setup
elif [ "$1" = "--help" ]
    
    cat << EOF
Available Commands:
    install
EOF
else
    echo "Command $1 not Available"
fi
