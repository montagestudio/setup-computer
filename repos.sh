#!/bin/bash

# Clones all the Declarativ repos to the current working directory.

NAME="clone repos"

echo "Start $NAME..."

# Please keep these in rough size order (smallest to largest) so that the
# smaller repos complete first.

git clone git@github.com:declarativ/palette.git
git clone git@github.com:declarativ/inspector.git
git clone git@github.com:declarativ/filament.git
git clone git@github.com:declarativ/montage.git
git clone git@github.com:declarativ/lumieres.git

echo "Done $NAME."
