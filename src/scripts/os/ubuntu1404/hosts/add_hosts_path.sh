#!/bin/bash
host_tag="#OpenStack node"

if [ "$1" = "" ] || [ "$2" == "" ] || [ "$3" == "" ]
	then
	echo "add_host failed"
	echo "Usage: add_host ip hostname host_file_path"
else
	hosts_file=$3
	echo "Host addition: Trying to add $2"
	sed -i "/\b\($host_tag $2\)\b/d" $hosts_file 
	echo "$host_tag [$2]" >> $hosts_file
	echo "$1 $2" >> $hosts_file
fi
