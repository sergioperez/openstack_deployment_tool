#!/bin/bash

#TODO: More configuration parameters
# Best example: allow (it will probably wont work without it)
# server parameters (offline, minpoll)

chrony_file="/etc/chrony/chrony.conf"

if [ "$1" = "" ]
	then
	echo "Bad Arguments:\n Usage: ./add_ntp_server.sh server"
else
	server=$1
	echo "# Server added with the installation script" >> $chrony_file 
	echo "server $server iburst" >> $chrony_file
	echo "Added '$server iburst' to $chrony_file"
fi
