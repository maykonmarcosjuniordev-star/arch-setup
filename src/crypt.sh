#!/bin/bash


#

function decrypt() {
    for file in $(ls -a credentials); do
        if [[ ! ("$file" == "." || "$file" == "..") ]]; then
            echo "Decrypting file: $file"
            openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$(pwd)/credentials/$file" -out "$(pwd)/tmp/$file"
        fi
    done
}
function encrypt() {
    for file in $(ls -a tmp); do
        if [[ ! ("$file" == "." || "$file" == ".." || "$file" == ".gitkeep") ]]; then
            echo "Encrypting file: $file"
            openssl enc -aes-256-cbc -salt -pbkdf2 -in "$(pwd)/tmp/$file" -out "$(pwd)/credentials/$file"
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