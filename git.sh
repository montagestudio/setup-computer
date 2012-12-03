#!/bin/bash

# Configure git

NAME="configuring Git"

echo "Start $NAME..."

USERNAME=`git config --global --get user.name`
if [[ $USERNAME == "" ]]; then
	echo "What is your name? (To appear as your git name)"
	read USERNAME
	git config --global user.name "$USERNAME"
fi

EMAIL=`git config --global --get user.email`
if [[ $EMAIL == "" ]]; then
	echo "What is your *PERSONAL* email address?"
	git config --global user.email "$EMAIL"
fi


git config --global alias.co checkout
git config --global alias.st status
git config --global alias.all "fetch --all"

git config --global color.ui true
 
git config --global rerere.enabled 1

echo "Done $NAME."
