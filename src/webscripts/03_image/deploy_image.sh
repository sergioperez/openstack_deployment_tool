#!/bin/bash

#Initialize database
. $OPENSTACK_DEPLOYER_PATH/image/db/db_setup.sh $ROOT_DBPASS

#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#Create glance user
. $OPENSTACK_DEPLOYER_PATH/openstack/create_user.sh glance $GLANCE_PASS
#Add admin role to glance user and service project
. $OPENSTACK_DEPLOYER_PATH/image/add_admin_role_to_glance_user_service_project.sh
#Create service entity
. $OPENSTACK_DEPLOYER_PATH/image/create_glance_service_entity.sh
#Create API endpoints
$OPENSTACK_DEPLOYER_PATH/image/create_api_endpoints.sh


#Install and configure components
##Install glance
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh glance
##Configure glance
. $OPENSTACK_DEPLOYER_PATH/image/configure_glance.sh
##Populate image service database
$OPENSTACK_DEPLOYER_PATH/image/populate_service_database.sh
##Restart glance service
. $OPENSTACK_DEPLOYER_PATH/image/restart_image_service.sh

