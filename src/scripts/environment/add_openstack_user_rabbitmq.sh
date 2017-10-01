#!/bin/bash

if [ "$1" == ""]
	then
	RABBIT_PASS=TODO: GENERATE RANDOM PASSWORD
	#TODO:
	echo "Not implemented yet. Use this script without arguments"
else
	RABBIT_PASS=$1
fi

rabbitmqctl add_user openstack $RABBIT_PASS
