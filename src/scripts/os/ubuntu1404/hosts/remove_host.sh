#!/bin/bash
hosts_file="/etc/hosts"

if [ "$1" = "" ] 
	then
	echo "remove_host failed"
	echo "Usage: ./remove_host.sh host_name"
else
	echo "Host removal: Trying to remove $1"
	sed -i "/\b\($1\)\b/d" $hosts_file
fi
