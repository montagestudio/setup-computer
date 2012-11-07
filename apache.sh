#!/bin/bash

# Sets up Apache

NAME="Apache setup"

echo "Start $NAME..."

USER=`whoami`
USER_WEBROOT="$HOME/Sites"
APACHE_CONFIG_FILE="/etc/apache2/users/$USER.conf"

echo -e "<Directory \"$USER_WEBROOT/\">\n"\
" Options Indexes MultiViews FollowSymLinks\n"\
" AllowOverride All\n"\
" Order allow,deny\n"\
" Allow from all\n"\
" Header set Expires \"Thu, 1 Jan 1900 00:00:00 GMT\"\n"\
"</Directory>" | sudo tee -a "$APACHE_CONFIG_FILE" 1>/dev/null
sudo chmod 0644 "$APACHE_CONFIG_FILE"

mkdir "$USER_WEBROOT"

sudo apachectl start

echo "Files are served from $USER_WEBROOT"
echo "Files can be accessed at http://localhost/~$USER"

echo "Done $NAME."
