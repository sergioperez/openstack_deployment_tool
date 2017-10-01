#!/bin/bash

#Create database and set access privileges
. $OPENSTACK_DEPLOYER_PATH/identity/db/db_setup.sh $ROOT_DBPASS

#Disable keystone autoinit
. $OPENSTACK_DEPLOYER_PATH/identity/disable_keystone_autoinit.sh

#Install keystone
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh keystone

#Install apache2
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh apache2 

#Install libapache2-mod-wsgi
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh libapache2-mod-wsgi


#Configure keystone
$OPENSTACK_DEPLOYER_PATH/identity/configure_keystone.sh $KEYSTONE_ADMINTOKEN $KEYSTONE_DBPASS


#Populate keystone database
$OPENSTACK_DEPLOYER_PATH/identity/populate_identity_database.sh


#Initialize Fernet keys
$OPENSTACK_DEPLOYER_PATH/identity/initialize_fernet_keys.sh

#Configure Apache
. $OPENSTACK_DEPLOYER_PATH/identity/configure_apache.sh

#Restart Apache service
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh apache2


#Remove SQLite database
$OPENSTACK_DEPLOYER_PATH/identity/remove_sqlite_database.sh


#Create service entity and API endpoints
###Export variables
. $OPENSTACK_DEPLOYER_PATH/identity/export_variables.sh
###Create entity service
$OPENSTACK_DEPLOYER_PATH/identity/create_identity_service.sh
###Create entity endpoints
. $OPENSTACK_DEPLOYER_PATH/identity/create_identity_endpoints.sh

##Create domain, project, users and roles
###Create default domain
$OPENSTACK_DEPLOYER_PATH/identity/create_domain.sh
###Create admin project
$OPENSTACK_DEPLOYER_PATH/identity/create_admin_project.sh
###Create admin user
$OPENSTACK_DEPLOYER_PATH/openstack/create_user.sh admin $ADMIN_PASS
###Create admin role
$OPENSTACK_DEPLOYER_PATH/identity/create_admin_role.sh
###Add admin role to admin user
$OPENSTACK_DEPLOYER_PATH/identity/add_role_admin_to_user_admin.sh
###Create service project
$OPENSTACK_DEPLOYER_PATH/identity/create_service_project.sh

##Create demo project and user
###Create demo project
$OPENSTACK_DEPLOYER_PATH/identity/create_demo_project.sh
###Create demo user
$OPENSTACK_DEPLOYER_PATH/openstack/create_user.sh demo $DEMO_PASS
###Create user role
$OPENSTACK_DEPLOYER_PATH/identity/create_user_role.sh
###Add user role to demo project and user
$OPENSTACK_DEPLOYER_PATH/identity/add_user_role_to_demo_user.sh


#Disable auth token mechanism
$OPENSTACK_DEPLOYER_PATH/identity/disable_auth_token_mechanism.sh

#Unset temporary variables
. $OPENSTACK_DEPLOYER_PATH/identity/unset_temporary_variables.sh



#Create OpenStack client environment scripts
echo "TODO READ USING ADMIN PASS $ADMIN_PASS"
. $OPENSTACK_DEPLOYER_PATH/openrc/create_admin_credentials.sh default default admin admin $ADMIN_PASS http://controller:35357/v3 3 2
. $OPENSTACK_DEPLOYER_PATH/openrc/create_admin_credentials.sh default default demo demo $DEMO_PASS http://controller:35357/v3 3 2

