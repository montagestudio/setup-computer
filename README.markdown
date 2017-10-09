Macbook setup
========================

The repo contains a number of script to make setting up a Macbook
easy, and to enable you maintaining a regular build of lumières.

Instructions
------------

Create a new directory, open the terminal and cd into it.
git clone git@github.com:montagestudio/setup.git
then run setup/setup/sh

This will create two directories in the same folder on is montagestudio 
with all the projects setup for live updates and on is bin with some 
command line addition to make your github life easier.

Setup build lumière in debug and release mode. For this step to complete succesfully 
you will need to install Xcode or at the minimum the Xcode command line tools.

Please note that setup will auto update itself each time it is run.

Adding a new script
-------------------

All scripts must be written in either Bash or Javascript. Copy one of the
templates from the `templates/` directory, and replace all the TODOs.

Look at the existing scripts to see how things have been done.

Add a call to your script in `setup.sh` at the right place.

Be careful that your script can be run repetitively without damage or unnecessary delays.
