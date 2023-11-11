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

