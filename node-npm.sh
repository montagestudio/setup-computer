#!/bin/bash

# Installs Node and NPM.

NAME="Node and NPM install"

echo "Start $NAME..."

echo "prefix = $HOMEBREW_DIR/share/npm" > ~/.npmrc

brew install node

echo "Done $NAME."
