#!/bin/bash

METADATA_CONF_FILE="/etc/neutron/metadata_agent.ini"

sed -i "s/^#nova_metadata_ip.*/nova_metadata_ip = controller/g" $METADATA_CONF_FILE
sed -i "s/^#metadata_proxy_shared_secret.*/metadata_proxy_shared_secret = $METADATA_SECRET/g" $METADATA_CONF_FILE
