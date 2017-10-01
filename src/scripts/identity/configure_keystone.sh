#!/bin/bash
KEYSTONE_CONF_PATH="/etc/keystone/keystone.conf"

if [ "$1" == "" ] || [ "$2" == "" ]
	then
	echo "Usage: ./configure_keystone.sh admin_token keystone_dbpass"
else
	ADMIN_TOKEN=$1
	KEYSTONE_DBPASS=$2

	#Admin token at [DEFAULT]
	sed -i  "/^\[DEFAULT\]/aadmin_token = $ADMIN_TOKEN" $KEYSTONE_CONF_PATH

	#Set verbose logging
	sed -i  "/^\[DEFAULT\]/averbose = True" $KEYSTONE_CONF_PATH

	#Database connection at [database]
	sed -i "s/^connection.*/connection = mysql+pymysql:\/\/keystone:$KEYSTONE_DBPASS@controller\/keystone/" $KEYSTONE_CONF_PATH

	#Configure memcache driver at [token]
	#sed -i "/^\[token\]/adriver = memcache" $KEYSTONE_CONF_PATH


	#Configure uuid token provider at [token]
        #sed -i "/^\[token\]/aprovider = uuid" $KEYSTONE_CONF_PATH
	#Configure fernet token provider at [fernet]

	sed -i "/^\[token\]/aprovider = fernet" $KEYSTONE_CONF_PATH

	#Configure sql driver at [revoke]
        #sed -i "/^\[revoke\]/adriver = sql" $KEYSTONE_CONF_PATH

	#Configure memcached service at [memcache]
        #sed -i "/^\[memcache\]/aservers = localhost:11211" $KEYSTONE_CONF_PATH

	
fi

