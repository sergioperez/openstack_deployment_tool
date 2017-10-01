#!/bin/bash

if [ "$1" == "" ]
	then
	echo "Usage: ./enable_silent_install.sh root_password"
else
	export DEBIAN_FRONTEND=noninteractive
	debconf-set-selections <<< "mariadb-server-5.5 mysql-server/root_password password $1"
	debconf-set-selections <<< "mariadb-server-5.5 mysql-server/root_password_again password $1"
fi
