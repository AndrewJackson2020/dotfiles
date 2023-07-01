#!/usr/bin/env bash

action=$1
if [ "$action" = "stow" ]
then
    echo "stowing config files"
    stow -d ./home -t ~/ . --verbose
    sudo stow -d ./system/ -t / . --verbose
    echo "config files stowed"
fi

if [ "$action" = "unstow" ]
then
    echo "unstowing config files"
    stow -d ./home -t ~/ -D . --verbose
    sudo stow -d ./ -t / -D . --verbose
    echo "config files unstowed"
fi
