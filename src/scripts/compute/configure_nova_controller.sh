#!/bin/bash
NOVA_CONF_FILE="/etc/nova/nova.conf"

if [ "$1" == "" ]
then
	echo "You should be calling this script by:"
	echo "		./configure_nova_controller.sh MANAGEMENT_IP"
else
MAN_IP=$1

#DEFAULT SECTION REPLACE
sed -i '/enabled_apis/cenabled_apis=osapi_compute,metadata' $NOVA_CONF_FILE

#DEFAULT SECTION ADD
echo "rpc_backend = rabbit" >> $NOVA_CONF_FILE
echo "auth_strategy = keystone" >> $NOVA_CONF_FILE
echo "my_ip = $MAN_IP" >> $NOVA_CONF_FILE
echo "use_neutron = True" >> $NOVA_CONF_FILE
echo "firewall_driver = nova.virt.firewall.NoopFirewallDriver" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#API_DATABASE SECTION ADD
echo "[api_database]" >> $NOVA_CONF_FILE
echo "connection = mysql+pymysql://nova:$NOVA_DBPASS@controller/nova_api" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[database] section add
echo "[database]" >> $NOVA_CONF_FILE
echo "connection = mysql+pymysql://nova:$NOVA_DBPASS@controller/nova" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[oslo_messaging_rabbit] add
echo "[oslo_messaging_rabbit]" >> $NOVA_CONF_FILE
echo "rabbit_host = controller" >> $NOVA_CONF_FILE
echo "rabbit_userid = openstack" >> $NOVA_CONF_FILE
echo "rabbit_password = $RABBIT_PASS" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[keystone_authtoken] add
echo "[keystone_authtoken]" >> $NOVA_CONF_FILE
echo "auth_uri = http://controller:5000" >> $NOVA_CONF_FILE
echo "auth_url = http://controller:35357" >> $NOVA_CONF_FILE
echo "memcached_servers = controller:11211" >> $NOVA_CONF_FILE
echo "auth_type = password" >> $NOVA_CONF_FILE
echo "project_domain_name = default" >> $NOVA_CONF_FILE
echo "user_domain_name = default" >> $NOVA_CONF_FILE
echo "project_name = service" >> $NOVA_CONF_FILE
echo "username = nova" >> $NOVA_CONF_FILE
echo "password = $NOVA_PASS" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[glance] section add
echo "[glance]" >> $NOVA_CONF_FILE
echo "api_servers = http://controller:9292" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[oslo_concurrency] section add
echo "[oslo_concurrency]" >> $NOVA_CONF_FILE
echo "lock_path = /var/lib/nova/tmp" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

#[vnc] section add
echo "[vnc]" >> $NOVA_CONF_FILE
echo "vncserver_listen = $MAN_IP" >> $NOVA_CONF_FILE
echo "vncserver_proxyclient_address = $MAN_IP" >> $NOVA_CONF_FILE
echo "" >> $NOVA_CONF_FILE

# Due to a packaging bug, remove the logdir option from the [DEFAULT] section.
sed -i '/^logdir/d' $NOVA_CONF_FILE
fi
