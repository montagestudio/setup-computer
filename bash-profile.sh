#!/bin/bash

# Setup bash profile
#
# Assume that $DECLARATIVBASEDIR is set and point to the current directory where the setup is done
#

NAME="bash profile setup"

echo "Start $NAME..."


export BIN_DIR=$DECLARATIVBASEDIR/bin

if [[ ! -d $BIN_DIR ]]; then
	mkdir -p $BIN_DIR
fi

pushd $BIN_DIR

if [ ! -f  "git-completion.bash" ]; then
	curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
	chmod +x git-completion.bash
fi

COMPLETIONINSTALLED=`cat ~/.bash_profile | grep git-completion`
if [[ $COMPLETIONINSTALLED == "" ]]; then
	echo "" >> ~/.bash_profile
	echo "# Git completion" >> ~/.bash_profile
	echo "source "$BIN_DIR/git-completion.bash >> ~/.bash_profile
fi

if [ ! -f  "git-prompt.sh" ]; then
	curl -O  https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
	chmod +x git-prompt.sh
fi

PROMPTINSTALLED=`cat ~/.bash_profile | grep git-prompt`
if [[ $PROMPTINSTALLED == "" ]]; then
	echo "source "$BIN_DIR/git-prompt.sh >> ~/.bash_profile
	echo "export PS1='\h:\W \u\[\e[1;30m\]\$(__git_ps1 \":%s\")\[\e[m\]$ '" >> ~/.bash_profile
fi

SUBTREEINSTALLED=`which git-subtree`
if [[ $PROMPTINSTALLED == "" ]]; then
	curl -O  https://raw.github.com/git/git/master/contrib/subtree/git-subtree.sh
	chmod +x git-subtree.sh
	mv git-subtree.sh git-subtree
fi

source ~/.bash_profile

popd

echo "Done $NAME."
