#!/bin/bash

MONGO_CONF_PATH="/etc/mongodb.conf"

if [ "$1" == "" ]
        then
                echo "Usage: ./configure_mongodb bind_address"
        else
        	sed -i "/^bind_ip/d" $MONGO_CONF_PATH
       		sed -i "3i\\bind_ip = $1" $MONGO_CONF_PATH
fi

