#!/bin/bash

# Configure git

NAME="configuring Git"

echo "Start $NAME..."

echo "What is your name? (To appear as your git name)"
read NAME

git config --global user.name "$NAME"

echo "What is your *PERSONAL* email address?"
read EMAIL

git config --global user.email "$EMAIL"

git config --global alias.co checkout
git config --global alias.st status

git config --global color.ui true

git config --global rerere.enabled 1

echo "Done $NAME."
