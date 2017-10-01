#!/bin/bash

NEUTRON_CONF_FILE="/etc/neutron/neutron.conf"


#In the database section, comment out any connection options because compute nodes do not directly access to the database
# (The only 'connection' entry that is on the file is the one at the [database] section)
sed -i "s/^connection/#connection/g" $NEUTRON_CONF_FILE


sed -i "s/^#rpc_backend.*/rpc_backend = rabbit/g" $NEUTRON_CONF_FILE
sed -i "s/^#auth_strategy.*/auth_strategy = keystone/g" $NEUTRON_CONF_FILE
sed -i "s/^#rabbit_host.*/rabbit_host = controller/g" $NEUTRON_CONF_FILE
sed -i "s/^#rabbit_userid.*/rabbit_userid = openstack/g" $NEUTRON_CONF_FILE
sed -i "s/^#rabbit_password.*/rabbit_password = $RABBIT_PASS/g" $NEUTRON_CONF_FILE



#[keystone_authtoken]
echo '[keystone_authtoken]' >> $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/apassword = $NEUTRON_PASS" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/ausername = neutron" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_name = service" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/auser_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/aproject_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_type = password" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/amemcached_servers = controller:11211" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_url = http://controller:35357" $NEUTRON_CONF_FILE
sed -i "/\[keystone_authtoken\]/aauth_uri = http://controller:5000" $NEUTRON_CONF_FILE

