#!/bin/bash

HASHOMEBREW=`brew`

if [[ $HASHOMEBREW == "" ]]; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
	brew install cmake
	brew install pkgconfig
	brew install pcre
	brew install libpng
else
 	echo "note - homebrew is already installed"        
fi

