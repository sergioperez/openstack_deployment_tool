#!/bin/bash

#TODO: More configuration parameters
# Best example: allow (it will probably wont work without it)
# server parameters (offline, minpoll)

if [ "$1" = "" ] || [ "$2" = "" ]
	then
	echo "Bad Arguments:\n Usage: ./add_ntp_server.sh server /path_to/chrony.conf"
else
	chrony_file=$2
	server=$1
	echo "# Server added with the installation script" >> $chrony_file 
	echo "server $server iburst" >> $chrony_file
	echo "Added '$chrony_file iburst' to $chrony_file"
fi
