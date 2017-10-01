#!/bin/bash

APACHE_CONF_FILE="/etc/apache2/apache2.conf"
WSGI_KEYSTONE_PATH="/etc/apache2/sites-available/wsgi-keystone.conf"

#Set servername to controller
	#Removes a possible previous ServerName entry
	sed -i '/^ServerName */d' $APACHE_CONF_FILE

	#Adds 'ServerName controller' at the begginning of the file
	sed -i '1s/^/ServerName controller\n/' $APACHE_CONF_FILE

#Create wsgi-keystone.conf file
	cp $OPENSTACK_DEPLOYER_PATH/identity/conf/wsgi-keystone.conf $WSGI_KEYSTONE_PATH

#Enable identity service virtual hosts
	ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled
