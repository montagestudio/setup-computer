#!/bin/bash

# Installs Node and NPM.

NAME="Node and NPM install"

echo "Start $NAME..."

HOMEBREW_DIR="/usr/local/homebrew"

echo "prefix = $HOMEBREW_DIR/share/npm" > ~/.npmrc

echo '# Add NPM bin path to PATH' >> ~/.bash_profile
echo 'export PATH="/usr/local/homebrew/share/npm/bin/:$PATH"' >> ~/.bash_profile

brew install node

echo "Done $NAME."
