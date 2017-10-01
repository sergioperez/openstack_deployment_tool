#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: . deploy_networking.sh provider_interface_name"
	echo "Example: . deploy_networking.sh eth1"
else
	PROV_IFACE=$2
	#Install packages #TODO It could ask about the changes in nova.conf
	. $OPENSTACK_DEPLOYER_PATH/networking/compute/install_components.sh

	#Configure neutron
	. $OPENSTACK_DEPLOYER_PATH/networking/compute/configure_neutron.sh

	#Configure networking options
	#Provider network (Self service networks not implemented)
	#TODO: Not writing PROVIDER_INTERFACE_NAME yet
	. $OPENSTACK_DEPLOYER_PATH/networking/compute/networking/provider/configure_linuxbridge_agent.sh $PROV_IFACE

	#Configure compute to use networking #TODO:The file being edited does not initially exist
	$OPENSTACK_DEPLOYER_PATH/networking/compute/configure_networking_usage.sh

	#Finalize installation
	. $OPENSTACK_DEPLOYER_PATH/networking/compute/finalize_installation.sh
fi
