#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]
then
	echo "Usage: ./create_openstack_user.sh username password"
else
	username=$1
	password=$2
	openstack user create --domain default \
  		--password $password $username
fi
