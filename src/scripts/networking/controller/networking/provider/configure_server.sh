#!/bin/bash

NEUTRON_CONF_FILE="/etc/neutron/neutron.conf"

#[DEFAULT] section
sed -i "s/^connection.*/connection = mysql+pymysql:\/\/neutron:$NEUTRON_DBPASS@controller\/neutron/g" $NEUTRON_CONF_FILE
sed -i "s/^core_plugin.*/core_plugin = ml2/g" $NEUTRON_CONF_FILE
sed -i "s/^#service_plugins.*/service_plugins =/g" $NEUTRON_CONF_FILE
sed -i "s/^#rpc_backend.*/rpc_backend = rabbit/g" $NEUTRON_CONF_FILE
sed -i "s/^#auth_strategy.*/auth_strategy = keystone/g" $NEUTRON_CONF_FILE
#nova
sed -i "s/^#notify_nova_on_port_status_changes.*/notify_nova_on_port_status_changes = True/g" $NEUTRON_CONF_FILE
sed -i "s/^#notify_nova_on_port_data_changes.*/notify_nova_on_port_data_changes = True/g" $NEUTRON_CONF_FILE


#[oslo_messaging_rabbit]
sed -i "s/^#rabbit_host.*/rabbit_host = controller/g" $NEUTRON_CONF_FILE
sed -i "s/^#rabbit_userid.*/rabbit_userid = openstack/g" $NEUTRON_CONF_FILE
sed -i "s/^#rabbit_password.*/rabbit_password = $RABBIT_PASS/g" $NEUTRON_CONF_FILE

#TODO: By default there are no keystone_authtoken and nova sections
echo '[keystone_authtoken]' >> $NEUTRON_CONF_FILE
echo '' >> $NEUTRON_CONF_FILE
echo '[nova]' >> $NEUTRON_CONF_FILE

#[keystone_authtoken]
sed -i "/^\[keystone_authtoken\]/apassword = $NEUTRON_PASS" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/ausername = neutron" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/aproject_name = service" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/auser_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/aproject_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/aauth_type = password" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/amemcached_servers = controller:11211" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/aauth_url = http:\/\/controller:35357" $NEUTRON_CONF_FILE
sed -i "/^\[keystone_authtoken\]/aauth_uri = http:\/\/controller:5000" $NEUTRON_CONF_FILE

#[nova]
sed -i "/\[nova\]/apassword = $NOVA_PASS" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/ausername = nova" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/aproject_name = service" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/aregion_name = RegionOne" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/auser_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/aproject_domain_name = default" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/aauth_type = password" $NEUTRON_CONF_FILE
sed -i "/\[nova\]/aauth_url = http:\/\/controller:35357" $NEUTRON_CONF_FILE

