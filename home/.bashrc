#!/bin/bash
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

sudo systemctl start iwd.service
sudo systemctl start docker.service
PATH=$PATH:~/.config/emacs/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/andrew/google-cloud-sdk/path.bash.inc' ]; then . '/home/andrew/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/andrew/google-cloud-sdk/completion.bash.inc' ]; then . '/home/andrew/google-cloud-sdk/completion.bash.inc'; fi


cli() {
	~/cli.sh "$@"
}

<<<<<<< HEAD
=======

# TODO move to separate file to faciliate better exception handling
cli () {
	case $1 in
		"--help" | "-h")
			main_help
			;;
        "install_aur_packages" | "i")
            sudo yay -S nordvpn-bin
            ;;
        "install_yay" | "y")
            # TODO Modify to cd back to original directory
            # TODO Modify to put repo in good location
            sudo git clone https://aur.archlinux.org/yay-git.git
            sudo chown -R andrew:andrew ./yay-git
            cd yay-git
            makepkg -si
            ;;
		"start_and_enable_services" | "s")
			sudo systemctl enable clamav-daemon
			sudo systemctl start clamav-daemoni
			;;
		"upload_encrypted_cloud_files" | "u")
			;;
        "download_encrypted_cloud_files" | "d")
            rm -f ~/cloud_documents/staging/*
            rm -f ~/cloud_documents/unzipped/*
            gsutil cp gs://documents_asdfoaucds/Documents.7z ~/cloud_documents/staging/
            cd ~/cloud_documents
            7z x  -ounzipped/ ~/cloud_documents/staging/Documents.7z
            cd -
            ;;
		*)
			echo "Command '$1' not recognized"
			main_help
			;;
	esac
}
>>>>>>> 32934d3 (Added services enable to bashrc)
