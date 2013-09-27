#!/bin/bash

# Install just the XCode command line tools

NAME="command line tools install"

echo "Start $NAME..."

XCODEVERSION=`xcodebuild -showsdks | grep -i "macosx"`

if [[ $XCODEVERSION == "" ]]; then

	echo "* Get Xcode and install the command line tools"
	echo "* Menu Preferences… tab Locations"
	echo "* Press enter when the install is complete"
	read
else
	echo "xcode tools found"	
fi

echo "Done $NAME."
