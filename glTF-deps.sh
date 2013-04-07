#!/bin/bash

HASHOMEBREW=`brew -v | grep Homebrew`
HASCMAKE=`brew list | grep cmake`
HASPKGCONFIG=`brew list | grep pkg-config`
HASPCRE=`brew list | grep pcre`
HASLIBPNG=`brew list | grep libpng`

if [[ $HASHOMEBREW == "" ]]; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
else
 	echo "note - homebrew is already installed"        
fi

if [[ $HASCMAKE == "" ]]; then
	brew install cmake
fi
if [[ $HASPKGCONFIG == "" ]]; then
	brew install pkgconfig
fi
if [[ $HASPCRE == "" ]]; then
	brew install pcre
fi
if [[ $HASLIBPNG == "" ]]; then
	brew install libpng
fi
