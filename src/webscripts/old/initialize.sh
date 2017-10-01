#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./initialize.sh release_url release_version"
	echo "Example: ./initialize.sh http://localhost/ release1.tar.gz"
else
	#Get root access
	sudo su

	#Go to /root
	cd

	#Download deploy scripts
	wget $1

	#Decompress scripts
	tar -zxvf release1.tar.gz

	#Source required variables
	source set_variables.sh

	#Source keys
	source keys/keys.sh

	#Generate routes ($OPENSTACK_DEPLOYER_PATH)
	./generate_routes.sh

	#Copy variables and keys scripts
	cp set_variables.sh $OPENSTACK_DEPLOYER_DEV
	cp keys/keys.sh $OPENSTACK_DEPLOYER_DEV
fi

