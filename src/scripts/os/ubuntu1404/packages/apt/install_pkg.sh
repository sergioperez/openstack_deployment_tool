#!/bin/bash

if [ "$1" = "" ]
	then
	echo "Usage: ./in.sh package-name"
else
	install_package=$1
	apt-get install -y $install_package 
fi
