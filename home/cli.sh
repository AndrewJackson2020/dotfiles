

main_help () {
	cat << EOF
Available Commands:
	download_encrypted_cloud_files | d
		Download encrypted .7z file from google cloud unencrypt and unzip files to local storage
EOF
}


download_encrypted_cloud_files () {

	set -e

	mkdir -p ~/cloud_documents/staging/
	mkdir -p ~/cloud_documents/unzipped/

	rm -f ~/cloud_documents/staging/*
	rm -f ~/cloud_documents/unzipped/*

	gsutil cp gs://documents_asdfoaucds/Documents.7z ~/cloud_documents/staging/
	cd ~/cloud_documents
	7z x  -ounzipped/ ~/cloud_documents/staging/Documents.7z
	cd -
}


cli () {
	case $1 in
		"--help" | "-h")
			main_help
			;;
		"start_and_enable_services" | "s")
			sudo systemctl enable clamav-daemon
			sudo systemctl start clamav-daemoni
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
		"u" | "upload_encrypted_cloud_files")
			;;
        "d" | "download_encrypted_cloud_files")
			download_encrypted_cloud_files 
			;;
		*)
			echo "Command '$1' not recognized"
			main_help
			;;
	esac
}


cli "$@"

