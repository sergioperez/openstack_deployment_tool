#!/bin/bash

if [ "$1" = "" ] || [ "$2" = "" ] 
	then
	echo "remove_host failed"
	echo "Usage: ./remove_host.sh host_name hosts_file"
else
	hosts_file=$2
	echo "Host removal: Trying to remove $1"
	sed -i "/\b\($1\)\b/d" $hosts_file
fi
