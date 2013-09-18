#!/bin/bash

# Install just the XCode command line tools

NAME="command line tools install"

echo "Start $NAME..."

XCODEVERSION=`xcodebuild -showsdks | grep -i "macosx"`

if [[ $XCODEVERSION == "" ]]; then

	#open files/xcode452cltools10_86938211a.dmg
	echo "* Get xcode452cltools10_86938211a.dmg from someone"
	echo "* Open the installer pkg"
	echo "* Press enter when the install is complete"
	read
else
	echo "xcode tools found"	
fi

echo "Done $NAME."
