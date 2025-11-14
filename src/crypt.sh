#!/bin/bash


USER_HOME=$HOME
TMP="$USER_HOME"/arch-setup/tmp/
CRED="$USER_HOME"/arch-setup/credentials/

function decrypt() {
    mkdir -p "$USER_HOME"/arch-setup/tmp/
    for file in $(ls -a "$CRED"); do
        if [[ ! ("$file" == "." || "$file" == "..") ]]; then
            echo "Decrypting file: $file"
            openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$CRED""$file" -out "$TMP""$file"
        fi
    done
}
function encrypt() {
    for file in $(ls -a "$USER_HOME"/arch-setup/tmp/); do
        if [[ ! ("$file" == "." || "$file" == "..") ]]; then
            echo "Encrypting file: $file"
            openssl enc -aes-256-cbc -salt -pbkdf2 -in "$TMP""$file" -out "$CRED""$file"
        fi
    done
}

case $1 in
	"encrypt")
		encrypt
		;;
	"decrypt")
		decrypt
		;;
	*)
		echo "Usage: $0 {encrypt|decrypt}"
		exit
esac