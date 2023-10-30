

main_help () {
	cat << EOF
Available Commands:
	download_encrypted_cloud_files | d
		Download encrypted .7z file from google cloud unencrypt and unzip files to local storage
	upload_encrypted_cloud_files 
	install_yay 
	start_and_enable_services 
EOF
}


help_download_encrypted_cloud_files (){
	cat << EOF
Function to encrypt and upload files to external cloud Bucket storage

flags:
	--document_type | d
		Document type to download, corresponds to subfolder
EOF
}


# TODO Separate video, audio, and documents into separate zip files
download_encrypted_cloud_files () {

	set -e

	case $1 in
		"--help" | "-h")
			help_download_encrypted_cloud_files 		
			;;
		"--document_type" | "-d")
			document_type=$2	
			;;
		*)
			echo "'$1' not recognized"
			help_download_encrypted_cloud_files 		
			exit
			;;
	esac

	mkdir -p ~/cloud_documents/staging/
	mkdir -p ~/cloud_documents/unzipped/

	rm -f ~/cloud_documents/staging/*
	rm -f ~/cloud_documents/unzipped/*

	gsutil cp \
		"gs://documents_asdfoaucds/${document_type}.7z" \
		"~/cloud_documents/staging/"
	cd ~/cloud_documents
	7z x  -ounzipped/ "~/cloud_documents/staging/${document_type}.7z"
	cd -
}


help_upload_encrypted_cloud_files () {
	cat << EOF
Function to encrypt and upload files to external cloud Bucket storage

flags:
	--document_type | d
		Document type to upload, corresponds to subfolder
EOF
}


# TODO Separate video, audio, and documents into separate zip files
upload_encrypted_cloud_files () {

	set -e

	case $1 in
		"--help" | "-h")
			help_download_encrypted_cloud_files 		
			;;
		"--document_type" | "-d")
			document_type=$2	
			;;
		*)
			echo "'$1' not recognized"
			help_download_encrypted_cloud_files 		
			exit
			;;
	esac

	echo "Please Enter Password"
	read password
	rm -f ~/cloud_documents/staging/*

	cd ~/cloud_documents
	7z a "-p${password}" -mhe=on "staging/${document_type}.7z" unzipped/*
	cd -

	gsutil cp \
		"~/cloud_documents/staging/${document_type}.7z" \
		"gs://documents_asdfoaucds/${document_type}.7z"
}


install_yay () {
	# TODO Modify to cd back to original directory
	# TODO Modify to put repo in good location
	sudo git clone https://aur.archlinux.org/yay-git.git
	sudo chown -R andrew:andrew ./yay-git
	cd yay-git
	makepkg -si
}


start_and_enable_services () {
	sudo systemctl enable clamav-daemon
	sudo systemctl start clamav-daemoni
}


cli () {
	case $1 in
		"--help" | "-h")
			main_help
			;;
		"start_and_enable_services" | "s")
			start_and_enable_services 
			;;
        "install_aur_packages" | "i")
            sudo yay -S nordvpn-bin
            ;;
        "install_yay" | "y")
			install_yay 
			;;
		"u" | "upload_encrypted_cloud_files")
			upload_encrypted_cloud_files "${@:2}"

			;;
        "d" | "download_encrypted_cloud_files")
			download_encrypted_cloud_files "${@:2}"
			;;
		*)
			echo "Command '$1' not recognized"
			main_help
			;;
	esac
}


cli "$@"

