#!/usr/bin/env bash

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
    
    sudo pacman -Syu --noconfirm  \
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
	virtualbox	
	    
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
