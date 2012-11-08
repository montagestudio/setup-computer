#!/bin/bash

# put a divider in between each step
function --- {
    echo
    echo "################################################################"
    echo
}

# Runs through all the scripts needed

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAIN_DIR=$HOME/Documents/declarativ

echo "Start Declarativ setup..."

mkdir -p $MAIN_DIR
---
$HERE/command-line-tools.sh
---
$HERE/apache.sh
---
$HERE/homebrew.sh
---
$HERE/node-npm.sh
---
$HERE/utilities.sh
---
$HERE/ssh-key.sh
---
$HERE/git.sh
---
$HERE/git-annex.sh
---
$HERE/bash_profile.sh
---
cd $MAIN_DIR
$HERE/repos.sh
cd $HERE

echo "Done Declarativ setup."
