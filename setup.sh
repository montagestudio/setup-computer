#!/bin/bash

# Runs through all the scripts needed

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAIN_DIR=$HOME/Documents/declarativ

echo "Start Declarativ setup..."

mkdir -p $MAIN_DIR

cd $MAIN_DIR
$HERE/repos.sh

echo "Done Declarativ setup."
