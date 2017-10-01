#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./mongodb.sh bind_address"
	echo "Example: ./mongodb.sh 10.0.0.1"
else
	#Install MongoDB server
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh mongodb-server

	#Install mongodb-clients
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh mongodb-clients 

	#Install python-pymongo
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh python-pymongo


	#Configure MongoDB
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/mongodb/configure_mongodb.sh $1

	#Restart MongoDB
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh mongodb


fi
