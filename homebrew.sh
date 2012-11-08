#!/bin/bash

# Installs homebrew package manager

NAME="homebrew install"

echo "Start $NAME..."

HOMEBREW_DIR="/usr/local/homebrew"

sudo mkdir -p "$HOMEBREW_DIR"
sudo chown -R `whoami` "$HOMEBREW_DIR"
curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C "$HOMEBREW_DIR"

# Add homebrew bin folder to $PATH
echo "export PATH=\"$HOMEBREW_DIR/bin:\$PATH\"" >> ~/.bash_profile
source ~/.bash_profile

echo "Done $NAME."
