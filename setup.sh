#!/bin/bash

# put a divider in between each step
function --- {
    echo
    echo "################################################################"
    echo
}

# Runs through all the scripts needed

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SELFUPDATE=".selfupdate"

if [[ -e $SELFUPDATE ]]; then
	rm -rf $SELFUPDATE

	BASEDIR=$HERE/..

	pushd $BASEDIR
	export DECLARATIVBASEDIR=`pwd`
	popd

	echo "Start Declarativ setup..."
	---
	$HERE/command-line-tools.sh
	---
	# $HERE/homebrew.sh
	---
	$HERE/node-npm.sh
	---
	# $HERE/glTF-deps.sh
	---
	$HERE/git.sh
	---
	$HERE/ssh-key.sh
	---
	$HERE/bash-profile.sh
	---
	$HERE/repos.sh ${1}
	---
	# Apache need the project in place or the configuration will fail
	$HERE/apache.sh

	echo "Done Declarativ setup."
	exit
else
	touch $SELFUPDATE
	
	RELAUNCH="${BASH_SOURCE[0]} ${1}"

	pushd $HERE
	git fetch --all
	GITSTATUS=`git status --short`
	if [[ $GITSTATUS != "" ]]; then
		git stash
	fi
	git rebase origin/master
	if [[ $GITSTATUS != "" ]]; then
		git stash pop
	fi
	popd
	
	bash $RELAUNCH
	exit
fi
