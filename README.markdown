Declarativ Macbook setup
========================

The repo contains a number of script to make setting up a Declarativ Macbook
easy.

Instructions
------------

Run `./setup.sh` for complete install. Most files will be installed to
`$HOME/Documents/declarativ`.

Alternatively read through `setup.sh` and run the scripts you need. Remember
to read the comment at the top of each script's file to see if it assumes
any state.

Adding a new script
-------------------

All scripts must be written in either Bash or Javascript. Copy one of the
templates from the `templates/` directory, and replace all the TODOs.

Look at the existing scripts to see how things have been done.

Add a call to your script in `setup.sh` at the right place.
