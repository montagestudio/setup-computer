#!/bin/bash

# Setup bash profile

NAME="bash profile setup"

echo "Start $NAME..."

BIN_DIR="$HOME/bin"


mkdir $BIN_DIR
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O $BIN_DIR/git-completion.bash
wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -O $BIN_DIR/git-prompt.sh

cat files/bash_profile >> $HOME/.bash_profile

source ~/.bash_profile

echo "Done $NAME."
