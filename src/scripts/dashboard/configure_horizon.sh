#!/bin/bash

NETWORK_TYPE=1

HORIZON_CONF_FILE="/etc/openstack-dashboard/local_settings.py"

#Configure the dashboard to use OpenStack services on the controller node:
sed -i 's/^OPENSTACK_HOST.*/OPENSTACK_HOST = "controller"/g' $HORIZON_CONF_FILE

#Allow all hosts to access the dashboard:
sed -i "s/^ALLOWED_HOSTS.*/ALLOWED_HOSTS = \['*', \]/g" $HORIZON_CONF_FILE

#Configure the memcached session storage service:
sed -i "s/'LOCATION'.*/'LOCATION': 'controller:11211',/g" $HORIZON_CONF_FILE

#Enable the Identity API version 3:
sed -i 's/^OPENSTACK_KEYSTONE_URL.*/OPENSTACK_KEYSTONE_URL = "http:\/\/%s:5000\/v3" % OPENSTACK_HOST/g' $HORIZON_CONF_FILE

#Enable support for domains:
sed -i "s/#OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT.*/OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True/g" $HORIZON_CONF_FILE
sed -i "s/^OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT.*/OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True/g" $HORIZON_CONF_FILE

#NOT DONE TODO Configure API versions

#Configure default as the default domain for users that you create via the dashboard:
sed -i 's/#OPENSTACK_KEYSTONE_DEFAULT_DOMAIN.*/OPENSTACK_KEYSTONE_DEFAULT_DOMAIN = "default"/g' $HORIZON_CONF_FILE
sed -i 's/^OPENSTACK_KEYSTONE_DEFAULT_DOMAIN.*/OPENSTACK_KEYSTONE_DEFAULT_DOMAIN = "default"/g' $HORIZON_CONF_FILE

#Configure user as the default role for users that you create via the dashboard:
sed -i 's/#OPENSTACK_KEYSTONE_DEFAULT_ROLE.*/OPENSTACK_KEYSTONE_DEFAULT_ROLE = "user"/g' $HORIZON_CONF_FILE
sed -i 's/^OPENSTACK_KEYSTONE_DEFAULT_ROLE.*/OPENSTACK_KEYSTONE_DEFAULT_ROLE = "user"/g' $HORIZON_CONF_FILE

#Configure API versions
sed -i 's/^#OPENSTACK_API_VERSIONS.*/OPENSTACK_API_VERSIONS = {\n&/' $HORIZON_CONF_FILE 
sed -i 's/^#OPENSTACK_API_VERSIONS.*/\t"identity": 3,\n&/' $HORIZON_CONF_FILE
sed -i 's/^#OPENSTACK_API_VERSIONS.*/\t"image": 2,\n&/' $HORIZON_CONF_FILE
sed -i 's/^#OPENSTACK_API_VERSIONS.*/\t"volume": 2,\n&/' $HORIZON_CONF_FILE
sed -i 's/^#OPENSTACK_API_VERSIONS.*/}\n&/' $HORIZON_CONF_FILE


#If you chose networking option 1, disable support for layer-3 networking services:
if [ $NETWORK_TYPE -eq 1 ]
then
	sed -i "s/'enable_router':.*/'enable_router': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_quotas':.*/'enable_quotas': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_distributed_router':.*/'enable_distributed_router': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_ha_router':.*/'enable_ha_router': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_lb':.*/'enable_lb': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_firewall':.*/'enable_firewall': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_vpn':.*/'enable_vpn': False,/g" $HORIZON_CONF_FILE
	sed -i "s/'enable_fip_topology_check':.*/'enable_fip_topology_check': False,/g" $HORIZON_CONF_FILE
fi


