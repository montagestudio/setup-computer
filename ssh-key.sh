#!/bin/bash

# Generate a SSH key for the user, and suggest that they add it to Github

NAME="SSH key generation"

echo "Start $NAME..."

if [[ -e ~/.ssh/id_rsa.pub ]]; then
	echo "You rsa key is setup nothing to do"
else
	ssh-keygen -t rsa	

	pbcopy < ~/.ssh/id_rsa.pub
	echo "Your public key has been copied to the clipboard."
	echo "Visit https://github.com/settings/ssh Add SSH key and paste"
	echo "Press enter to continue"
	read
	echo "You will also need to configure your account on declarativ.com"
	read
fi

echo "Done $NAME."
