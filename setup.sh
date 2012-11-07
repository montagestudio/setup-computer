#!/bin/bash

# Runs through all the scripts needed

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAIN_DIR=$HOME/Documents/declarativ

echo "Start Declarativ setup..."

mkdir -p $MAIN_DIR

$HERE/manual-steps.sh

$HERE/homebrew.sh

$HERE/node-npm.sh

$HERE/utilities.sh

cd $MAIN_DIR
$HERE/repos.sh
cd $HERE

echo "Done Declarativ setup."
