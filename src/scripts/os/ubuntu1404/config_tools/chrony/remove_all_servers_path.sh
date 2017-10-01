#!/bin/bash

if [ "$1" = "" ]
        then
        echo "remove_ntp_servers failed"
        echo "Usage: ./remove_ntp_servers.sh PATH_TO_CHRONY"
else
	chrony_file=$1
	echo "NTP Servers removal : Removing all servers"
	sed -i "/^server/d" $chrony_file
	echo "Removed all servers from $chrony_file"
fi
