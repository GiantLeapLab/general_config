#!/bin/sh
#more details
#http://aboutubuntu.ru/apache2-ssl-self-sert-for-https-connection-on-ubuntu.html
#http://aboutubuntu.ru/apache-ssl-https-ubuntu.html
#http://help.ubuntu.ru/wiki/apache_%D0%B8_https
#https://www.linode.com/docs/websites/ssl/ssl-certificates-with-apache-2-on-ubuntu

#if [ "$(whoami)" != "root" ]
#then
#  echo "You have to run this script as Superuser!"
#  exit 1
#fi

CFG_FNAME='mysite-ssl.conf'
SSL_FNAME='mysite'

sudo a2enmod ssl
sudo mkdir /etc/apache2/ssl
sudo openssl req -new -x509 -days 365 -nodes -out /etc/apache2/ssl/${SSL_FNAME}.pem -keyout /etc/apache2/ssl/${SSL_FNAME}.key
sudo cp $CFG_FNAME /etc/apache2/sites-available/${CFG_FNAME}

sudo a2ensite $CFG_FNAME
sudo service apache2 restart
