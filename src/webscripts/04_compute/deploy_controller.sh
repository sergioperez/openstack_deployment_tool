#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: . deploy_controller.sh MANAGEMENT_IP"
	echo "Example: . deploy_controller.sh 10.0.0.1"
	exit
fi

#Initialize database
. $OPENSTACK_DEPLOYER_PATH/compute/db/db_setup.sh $ROOT_DBPASS

#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#Create service credentials
##Create nova user
. $OPENSTACK_DEPLOYER_PATH/openstack/create_user.sh nova $NOVA_PASS
##Add admin role to nova user
$OPENSTACK_DEPLOYER_PATH/compute/set_nova_admin_role.sh
##Create nova service entity
$OPENSTACK_DEPLOYER_PATH/compute/create_nova_service_entity.sh

##Create compute API endpoints
$OPENSTACK_DEPLOYER_PATH/compute/create_compute_service_api_endpoints.sh


#Install and configure packages
##Install nova-api,nova-conductor,nova-consoleauth,nova-novncproxy,nova-scheduler
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-api && \
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-conductor && \
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-consoleauth && \
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-novncproxy && \
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh nova-scheduler
##Configure nova
. $OPENSTACK_DEPLOYER_PATH/compute/configure_nova_controller.sh $MAN_IP
##Populate compute databases
$OPENSTACK_DEPLOYER_PATH/compute/populate_compute_databases.sh

#Finalize installation
##Restart services for loading changes
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-api
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-consoleauth
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-scheduler
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-conductor
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-novncproxy
