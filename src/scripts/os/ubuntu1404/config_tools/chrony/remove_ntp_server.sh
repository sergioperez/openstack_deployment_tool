#!/bin/bash

#TODO: More configuration parameters
# Best example: allow (it will probably wont work without it)
# server parameters (offline, minpoll)

chrony_file="/etc/chrony/chrony.conf"

if [ "$1" = "" ]
	then
	echo "Bad Arguments:\n Usage: ./remove_ntp_server.sh server"
else
	server=$1
	sed -i "/\b$server\b/d" $chrony_file
	echo "Removing $server from $chrony_file"
fi
