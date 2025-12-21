#!/bin/bash


USER_HOME=$HOME
CRED="$USER_HOME"/arch-setup/credentials/
VAULT="$USER_HOME"/arch-setup/vault/

function decrypt() {
    mkdir -p "$CRED"
    for file in $(ls -a "$VAULT"); do
        if [[ ! ("$file" == "." || "$file" == "..") ]]; then
            read -p "Do you want to decrypt the file $file? (y/n) " choice
            if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
                echo "Decrypting file: $file"
                openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$VAULT""$file" -out "$CRED""$file"
            fi
        fi
    done
}
function encrypt() {
    for file in $(ls -a "$CRED"); do
        if [[ ! ("$file" == "." || "$file" == "..") ]]; then
            echo "Encrypting file: $file"
            openssl enc -aes-256-cbc -salt -pbkdf2 -in "$CRED""$file" -out "$VAULT""$file"
        fi
    done
}

case $1 in
	"e")
		encrypt
		;;
	"d")
		decrypt
		;;
	*)
		echo "Usage: $0 {e (Encrypt) |d (Decrypt)}"
		exit
esac