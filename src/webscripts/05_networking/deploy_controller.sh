#!/bin/bash
if [ "$1" == "" ] || [ "$2" == "" ]
then
	echo "./deploy.sh network_type provider_interface_name"
	echo "Where network_type:
			1=>Provider networks
			2=>Self-service networks" 
	echo "Example:"
	echo "./deploy.sh 1 eth1"
else
	NET_OPTION=$1
	PROV_INTERFACE_NAME=$2

	#Initialize database
	. $OPENSTACK_DEPLOYER_PATH/networking/controller/db/db_setup.sh $ROOT_DBPASS

	#Source admin credentials
	. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

	#Create service credentials
	##Create neutron user
	$OPENSTACK_DEPLOYER_PATH/openstack/create_user.sh neutron $NEUTRON_PASS
	##Add admin role to neutron user
	$OPENSTACK_DEPLOYER_PATH/networking/controller/add_admin_role_to_neutron_user.sh
	##Create neutron service entity
	$OPENSTACK_DEPLOYER_PATH/networking/controller/create_neutron_service_entity.sh

	#Create networking API endpoints
	$OPENSTACK_DEPLOYER_PATH/networking/controller/create_neutron_api_endpoints.sh

	#Configure network options
	#TODO: Self-service networks not implemented yet
	if [ "$NET_OPTION" == "1" ]
	then
		#Install packages
		. $OPENSTACK_DEPLOYER_PATH/networking/controller/networking/provider/install_packages.sh
		#Configure neutron
		. $OPENSTACK_DEPLOYER_PATH/networking/controller/networking/provider/configure_server.sh
		#Configure ml2
		. $OPENSTACK_DEPLOYER_PATH/networking/controller/networking/provider/configure_ml2.sh
		#Configure linuxbridge agent
		. $OPENSTACK_DEPLOYER_PATH/networking/controller/networking/provider/configure_linuxbridge_agent.sh $PROV_INTERFACE_NAME
		#Configure DHCP agent
		. $OPENSTACK_DEPLOYER_PATH/networking/controller/networking/provider/configure_dhcp_agent.sh $PROV_INTERFACE_NAME
		#TODO: There is no keystone_authtoken section
		#TODO: There is no nova section
	fi
	
	#Configure the metadata agent
	. $OPENSTACK_DEPLOYER_PATH/networking/controller/other/configure_metadata.sh

	#Configure compute to use networking
	. $OPENSTACK_DEPLOYER_PATH/networking/controller/other/configure_nova_compute.sh

	#Populate database
	$OPENSTACK_DEPLOYER_PATH/networking/controller/other/populate_database.sh

	#Restart services
	. $OPENSTACK_DEPLOYER_PATH/networking/controller/other/restart_services.sh
fi
