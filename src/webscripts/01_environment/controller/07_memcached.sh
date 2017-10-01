#!/bin/bash
if [ "$1" == "" ]
then
	echo "Usage: ./memcached.sh bind_address"
	echo "Example: ./memcached.sh 10.0.0.1"
else
	#Install memcached
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh memcached

	#Install python-memcache
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh python-memcache

	#Configure memcached
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/memcached/configure_memcached.sh $1

	#Restart memcached for applying changes
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh memcached

fi
