#!/usr/bin/env bash

stow_config_files () {
    echo "stowing config files"
    stow -d ./home -t ~/ . --verbose
    sudo stow -d ./system/ -t / . --verbose
    echo "config files stowed"
}

unstow_config_files () {
    echo "unstowing config files"
    stow -d ./home -t ~/ -D . --verbose
    sudo stow -d ./ -t / -D . --verbose
    echo "config files unstowed"
}

install_packages () {
    echo "installing packages"
    
    # Use to find best mirrors
    pacman -S --noconfirm  \
    	reflector \
    	i3-gaps \
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
	stow

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
