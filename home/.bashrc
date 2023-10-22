#
# ~/.bashrc
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


main_help () {
	cat << EOF
Available Commands:
EOF
}



cli () {
	case $1 in
		"--help" | "-h")
			main_help
			;;
        "download_encrypted_cloud_files" )
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
