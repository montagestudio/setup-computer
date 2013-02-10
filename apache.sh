#!/bin/bash

# Sets up Apache
#
# Assume that $DECLARATIVBASEDIR is set and point to the current directory where the setup is done
#
# Depending on your preferences you may want to change the server port
#
MACOSXSERVERPORT=8082

NAME="Apache setup"

echo "Start $NAME..."

ISSERVERINSTALLED=`serverinfo --software | grep "NOT"`

if [[ $ISSERVERINSTALLED == "" ]]; then
	echo "MacOS X Server configuration"
	APACHE_CONFIG_FILE="/Library/Server/Web/Config/apache2/other/montage-declarativ.conf"
	if [[ -e $APACHE_CONFIG_FILE ]]; then
		echo "Apache already configured"
		cat $APACHE_CONFIG_FILE
	else
		DOCROOT="$DECLARATIVBASEDIR/declarativ/montage"
		echo -e -n "Listen $MACOSXSERVERPORT\n"\
"NameVirtualHost *:$MACOSXSERVERPORT\n"\
"#LogLevel debug\n"\
"\n"\
"<VirtualHost *:$MACOSXSERVERPORT>\n"\
"\tDocumentRoot \"$DOCROOT\"\n"\
"\t\n"\
"\t<Directory $DOCROOT>\n"\
"\t\tOptions All +FollowSymLinks +Indexes\n"\
"\t\tAllowOverride All\n"\
"\t\tOrder allow,deny\n"\
"\t\tAllow from all\n"\
"\t</Directory>\n"\
"\t\n"\
"\t#Optional touch friendly index page\n"\
"\tAlias /montage-index $DOCROOT/etc/apache-montage-index\n"\
"\tInclude $DOCROOT/etc/apache-montage-index/index.conf\n"\
"\t\n"\
"\t<IfModule deflate_module>\n"\
"\t\tSetOutputFilter DEFLATE\n"\
"\t\t\n"\
"\t\t# Don't compress images\n"\
"\t\tSetEnvIfNoCase Request_URI \\.(?:gif|jpe?g|png|bin)$ no-gzip dont-vary\n"\
"\t</IfModule>\n"\
"\t\n"\
"\tHeader append Cache-Control \"no-cache\"\n"\
"\t\n"\
"</VirtualHost>\n" | sudo tee "$APACHE_CONFIG_FILE" 1>/dev/null                                                                                                                                                                
		sudo chmod 0644 "$APACHE_CONFIG_FILE"

		echo "new apache configuration"
		cat "$APACHE_CONFIG_FILE"
  		
		RUN=`sudo serveradmin status web | grep RUNNING`
		if [[ $RUN != "" ]]; then
			sudo serveradmin stop web
		fi
		sudo serveradmin start web
	
		echo "Files are served from $DOCROOT"
		echo "Files can be accessed at http://localhost:$MACOSXSERVERPORT"
	fi
	
else
	echo "MacOS X Client configuration"
	USER=`whoami`
	USER_WEBROOT="$HOME/Sites"
	APACHE_CONFIG_FILE="/etc/apache2/users/$USER.conf"

	if [[ -e $APACHE_CONFIG_FILE ]]; then
		echo "apache already configured"
		cat $APACHE_CONFIG_FILE
	else
		# This does not look right
		
		echo -e "<Directory \"$USER_WEBROOT/\">\n"\
		" Options Indexes MultiViews FollowSymLinks\n"\
		" AllowOverride All\n"\
		" Order allow,deny\n"\
		" Allow from all\n"\
		" Header set Expires \"Thu, 1 Jan 1900 00:00:00 GMT\"\n"\
		"</Directory>" | sudo tee -a "$APACHE_CONFIG_FILE" 1>/dev/null
		sudo chmod 0644 "$APACHE_CONFIG_FILE"

		if [[ ! -d $USER_WEBROOT ]]; then
			mkdir -p $USER_WEBROOT
		fi

		RUN=`ps ax | grep /usr/sbin/httpd | grep -v grep | cut -c1-5 | paste -s -`
		if [[ $RUN != "" ]]; then
			sudo apachectl restart
		else
			sudo apachectl start
		fi
	fi

	echo "Files are served from $USER_WEBROOT"
	echo "Files can be accessed at http://localhost/~$USER"

fi

echo "Done $NAME."
