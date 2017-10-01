#!/bin/bash

GLANCE_CONF_FILE="/etc/glance/glance-api.conf"
GLANCE_REGISTRY_CONF_FILE="/etc/glance/glance-registry.conf"

#TODO: Get $GLANCE_DBPASS and $GLANCE_PASS from somewhere

#########3
## GLANCE_CONF_FILE

#I do not know if it is needed but:
#Commenting sqlite_db
sed -i "s/sqlite_db = \/var\/lib\/glance\/glance.sqlite/#sqlite_db = \/var\/lib\/glance\/glance.sqlite/g" $GLANCE_CONF_FILE

#[database] section
#	Set database address 
sed -i "/\[database\]/aconnection = mysql+pymysql:\/\/glance:$GLANCE_DBPASS@controller/glance" $GLANCE_CONF_FILE 

#[keystone_authtoken] section
sed -i "/\[keystone_authtoken\]/apassword = $GLANCE_PASS" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/ausername = glance" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_name = service" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/auser_domain_name = default" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_domain_name = default" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_type = password" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/amemcached_servers = controller:11211" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_url = http://controller:35357" $GLANCE_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_uri = http://controller:5000" $GLANCE_CONF_FILE

#[paste_deploy] section
sed -i "/\[paste_deploy\]/aflavor = keystone" $GLANCE_CONF_FILE

#[glance_store] section
sed -i "/\[glance_store\]/afilesystem_store_datadir = /var/lib/glance/images/" $GLANCE_CONF_FILE
sed -i "/\[glance_store\]/adefault_store = file" $GLANCE_CONF_FILE
sed -i "/\[glance_store\]/astores = file,http" $GLANCE_CONF_FILE

#########
### GLANCE_REGISTRY_CONF_FILE

#[database] section
#       Set database address 
sed -i "/\[database\]/aconnection = mysql+pymysql:\/\/glance:$GLANCE_DBPASS@controller/glance" $GLANCE_REGISTRY_CONF_FILE

#[keystone_authtoken] section
sed -i "/\[keystone_authtoken\]/apassword = $GLANCE_PASS" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/ausername = glance" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_name = service" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/auser_domain_name = default" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_domain_name = default" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_type = password" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/amemcached_servers = controller:11211" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_url = http://controller:35357" $GLANCE_REGISTRY_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_uri = http://controller:5000" $GLANCE_REGISTRY_CONF_FILE

#[paste_deploy] section
sed -i "/\[paste_deploy\]/aflavor = keystone" $GLANCE_REGISTRY_CONF_FILE

