#!/bin/bash
NOVA_CONF_FILE="/etc/nova/nova.conf"

echo '[neutron]' >> $NOVA_CONF_FILE
echo 'url = http://controller:9696' >> $NOVA_CONF_FILE
echo 'auth_url = http://controller:35357' >> $NOVA_CONF_FILE
echo "auth_type = password" >> $NOVA_CONF_FILE
echo "project_domain_name = default" >> $NOVA_CONF_FILE
echo "user_domain_name = default" >> $NOVA_CONF_FILE
echo "region_name = RegionOne" >> $NOVA_CONF_FILE
echo "project_name = service" >> $NOVA_CONF_FILE
echo "username = neutron" >> $NOVA_CONF_FILE
echo "password = $NEUTRON_PASS" >> $NOVA_CONF_FILE

echo "service_metadata_proxy = True" >> $NOVA_CONF_FILE
echo "metadata_proxy_shared_secret = $METADATA_SECRET" >> $NOVA_CONF_FILE
