#!/bin/bash

# Generate a SSH key for the user, and suggest that they add it to Github

NAME="SSH key generation"

echo "Start $NAME..."

ssh-keygen

pbcopy < ~/.ssh/id_rsa.pub
echo "Your public key has been copied to the clipboard."
echo "Visit https://github.com/settings/ssh Add SSH key and paste"
echo "Press enter to continue"
read

echo "Done $NAME."
