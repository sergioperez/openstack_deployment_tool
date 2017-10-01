#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]
then
	echo "Usage: ./configure_rabbitmq.sh rabbit_username rabbit_password"
else
	rabbitmqctl add_user $1 $2
	rabbitmqctl set_permissions $1 ".*" ".*" ".*"
fi
