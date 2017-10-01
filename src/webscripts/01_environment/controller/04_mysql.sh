#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./mysql.sh bind_address"
	echo "Example: ./mysql.sh 10.0.0.1"
else

	#Enable silent install
	echo "TODO: REMOVE READ MYSQL PASS $ROOT_DBPASS"
	. $OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/mariadb/enable_silent_install.sh $ROOT_DBPASS

	#Install mariadb-server
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh mariadb-server

	#Install python-pymysql
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh python-pymysql

	#Configure MariaDB server
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/mariadb/configure_mariadb.sh $1

	#Restart MariaDB
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh mysql

fi
