#!/bin/bash

MEMCACHED_CONF_FILE="/etc/memcached.conf"

if [ "$1" == "" ]
	then
	echo "Usage ./configure_memcached.sh bind_ip"
else
	#Change -i ACTUAL_IP to -i bind_ip 
	sed -i "s/^-l.*/-l $1/g" $MEMCACHED_CONF_FILE
	#Print result:
	cat $MEMCACHED_CONF_FILE | grep "\-l"
fi
