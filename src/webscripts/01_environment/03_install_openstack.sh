#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./install_openstack.sh openstack_repository"
	echo "Example: ./install_openstack.sh cloud-archive:mitaka" 
else
	echo "Installing OpenStack from $1"

	#Install software-properties-common
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh software-properties-common
	
	#Adding OpenStack repository
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/add_repository.sh $1

	#Update packages list
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/update_lists.sh

	#Install OpenStack client
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh python-openstackclient


fi

