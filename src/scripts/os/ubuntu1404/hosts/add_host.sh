#!/bin/bash
host_tag="#OpenStack node"
hosts_file="/etc/hosts"


if [ "$1" = "" ] || [ "$2" == "" ]
	then
	echo "add_host failed"
	echo "Usage: add_host ip hostname"
else
	echo "Host addition: Trying to add $2"
	sed -i "/\b\($host_tag $2\)\b/d" $hosts_file 
	echo "$host_tag [$2]" >> $hosts_file
	echo "$1 $2" >> $hosts_file
fi
