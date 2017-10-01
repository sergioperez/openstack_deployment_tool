#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: ./deploy_compute.sh management_ip"
else
	MANAGEMENT_IP=$1
	#Install packages
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-compute
	#Configure nova
	. $OPENSTACK_DEPLOYER_PATH/compute/configure_nova_compute.sh $MANAGEMENT_IP

	#Configure libvirt to use qemu or kvm
	$OPENSTACK_DEPLOYER_PATH/compute/configure_libvirt.sh

	#Restart compute service for loading changes
	$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-compute


fi
