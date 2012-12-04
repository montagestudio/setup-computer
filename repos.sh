#!/bin/bash

# Clones all the Declarativ repos to the current working directory.

NAME="clone repos"

echo "Start $NAME..."

export GITHUB="github.com"

export MAIN_DIR=$DECLARATIVBASEDIR/declarativ

if [[ ! -d $MAIN_DIR ]]; then
	mkdir -p $MAIN_DIR
fi

pushd $MAIN_DIR


function checkout
{
	echo "****************************************"
	echo "* Updating $1 from $2 *"
	echo "****************************************"
	if [[ ! -d $1 ]]; then
		git clone git@$GITHUB:$2/$1.git
	fi
	pushd $1
	git fetch --all
	git rebase origin/master
}

function installpackages
{
	PROJECTDIR=$1
	if [[ $PROJECTDIR == "" ]]; then
		PROJECTDIR=`pwd`
	fi
	rm -rf node_modules
	npm install
	if [[ ! -d node_modules ]]; then
		mkdir node_modules
	fi
	pushd node_modules
	MODULES=`ls -1d *`
	if [[ $MODULES != "" ]]; then
		for package in $MODULES; do
			if [[ -d $PROJECTDIR/$package ]]; then
				echo "we have the project $package checked out so make a link"
				rm -rf "$package"
				ln -s $PROJECTDIR/$package $package
			fi
		done
	fi
	popd
}

checkout "mr" "montagejs"
installpackages $MAIN_DIR
popd

checkout "collections" "montagejs"
installpackages $MAIN_DIR
popd

checkout "frb" "montagejs"
installpackages $MAIN_DIR
popd

checkout "montage" "montagejs"
installpackages $MAIN_DIR
popd

checkout "palette" "declarativ"
installpackages $MAIN_DIR
# Palette has 2 sets of dependencies so we need 2 runs
pushd stage
installpackages $MAIN_DIR
popd
popd

checkout "flow-editor" "declarativ"
installpackages $MAIN_DIR
popd

checkout "filament" "declarativ"
# palette and flow-editor are not in npm so we need to add them in the dependencies
# We should fix that with a private npm repository
cp package.json package.json.saved
cat package.json.saved | grep -v "palette" | grep -v "flow-editor" | sed '/,$/ { N 
/\n.*\}/ s/,.*\n.*\}/\
\}/ 
}' > package.json 

installpackages $MAIN_DIR

pushd node_modules
rm -rf palette
ln -s $MAIN_DIR/palette palette
rm -rf flow-editor
ln -s $MAIN_DIR/flow-editor flow-editor
popd
rm -rf package.json
mv package.json.saved package.json
popd

checkout "lumieres" "declarativ"
# npm install is done in the xcode build so no need to do it
XCODEPATH=`xcode-select --print-path`
echo "build lumières using "$XCODEPATH
xcodebuild clean build -configuration Release
xcodebuild clean build -configuration Debug
popd

popd

echo "Done $NAME."
