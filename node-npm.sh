#!/bin/bash

# Installs Node and NPM.
#
# Assume that $DECLARATIVBASEDIR is set and point to the current directory where the setup is done
#

NAME="Node and NPM install"

echo "Start $NAME..."

export TMP_DIR=$DECLARATIVBASEDIR/tmp

rm -rf $TMP_DIR
mkdir -p $TMP_DIR

NODEWEBSITE="http://nodejs.org/dist/latest/"

NODEINSTALLER=`curl -s $NODEWEBSITE | grep "pkg" | cut -d'>' -f 2 | cut -d'<' -f 1`
NODEVERSION=`echo $NODEINSTALLER | cut -d'-' -f 2 | cut -d '.' -f '1 2 3'`
NODEURL=$NODEWEBSITE$NODEINSTALLER
CURRENTNODEVERSION=`node --version`

if [[ $CURRENTNODEVERSION != $NODEVERSION ]]; then
	echo "Updating node";
	if [[ -d $TMP_DIR ]]; then
		pushd $TMP_DIR
	else
		pushd /tmp
	fi
	curl -O $NODEURL
	echo `sudo installer -pkg $NODEINSTALLER -target /`
	popd
else
	echo "Node is up-to-date"
fi
CURRENTNODEVERSION=`node --version`

CURRENTNPMVERSION=`npm --version`

echo "This machine has node "$CURRENTNODEVERSION" and npm "$CURRENTNPMVERSION" installed"

rm -rf $TMP_DIR

echo "Done $NAME."
