#!/bin/bash

# Clones all the Declarativ repos to the current working directory.
#
# Assume that $DECLARATIVBASEDIR is set and point to the current directory where the setup is done
#

NAME="clone repos"

echo "Start $NAME..."

if [[ $GITHUBDECLARATIV == "" ]]; then
	export GITHUBDECLARATIV="github.com"
fi

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
		git clone git@$GITHUBDECLARATIV:$2/$1.git
	fi
	pushd $1
	rm -f npm-debug.log
	git fetch --all
	branchname=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

	GITSTATUS=`git status --short -u no`
	if [[ $GITSTATUS != "" ]]; then
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "! Cannot update $1 because of uncommited changes on $branchname !"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		exit -1;
	fi

	if [[ $branchname == "master" ]]; then
		git rebase remotes/origin/master
	else
        git rebase master remotes/origin/master
		git co $branchname
	fi
}

function installpackages
{
	# This will install the packages for each module using npm install
	# It will then replace installed projects with softl link between projects
	# we do not use npm link as we don't want global machine link but a local link
	#
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

checkout "q" "kriskowal"
installpackages $MAIN_DIR
popd

checkout "q-io" "kriskowal"
installpackages $MAIN_DIR
popd

checkout "q-connection" "kriskowal"
installpackages $MAIN_DIR
popd

checkout "mr" "montagejs"
installpackages $MAIN_DIR
# This is a special case for mr
pushd node_modules
	rm -rf q
	ln -s ../packages/q q
popd
popd

checkout "collections" "montagejs"
installpackages $MAIN_DIR
popd

checkout "frb" "montagejs"
installpackages $MAIN_DIR
popd

checkout "mousse" "montagejs"
installpackages $MAIN_DIR
popd

checkout "montage-testing" "montagejs"
installpackages $MAIN_DIR
rm -rf node_modules/montage
popd

checkout "montage" "montagejs"
installpackages $MAIN_DIR
popd

checkout "native" "montagejs"
installpackages $MAIN_DIR
popd

checkout "matte" "montagejs"
installpackages $MAIN_DIR
popd

checkout "digit" "montagejs"
installpackages $MAIN_DIR
popd

checkout "minit" "montagejs"
installpackages $MAIN_DIR
popd

checkout "mop" "montagejs"
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

checkout "glTF-node-module" "declarativ"
git submodule update --init --recursive
pushd glTF
git checkout origin/montage-edge
popd
installpackages $MAIN_DIR
popd

checkout "filament" "declarativ"
# palette and flow-editor are not in npm so we need to hack the package.json file to make it work
# We should fix that with a private npm repository
cp package.json package.json.saved
cat package.json.saved | sed s/github.com/$GITHUBDECLARATIV/ > package.json

installpackages $MAIN_DIR

# cleanup after ourselves
rm -rf package.json
mv package.json.saved package.json
popd

checkout "lumieres" "declarativ"
# npm install is done in the xcode build so no need to do it
# just clean the node_modules
pushd lumieres/server/
rm -rf node_modules
npm install
popd
XCODEPATH=`xcode-select --print-path`
echo "build lumières using "$XCODEPATH
if [[ $1 == "--release" ]]; then
    echo "build Release"
    xcodebuild clean build -configuration Release
else
    echo "build Release"
    xcodebuild clean build -configuration Release
    echo "build Debug"
    xcodebuild clean build -configuration Debug
fi
popd

popd

echo "Done $NAME."
