#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./ntp.sh ntp_server_address"
	echo "Example: ./ntp.sh hora.rediris.es"
else
	#Update packages list
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/update_lists.sh

	#Install chrony
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh chrony

	#Remove all configured ntp servers
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/chrony/remove_all_servers.sh

	#Add specified ntp server
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/chrony/add_ntp_server.sh $1

	#Restart chrony service for applying changes
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh chrony

fi
