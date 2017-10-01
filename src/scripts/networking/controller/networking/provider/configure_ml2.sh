#!/bin/bash

ML2_CONF_FILE="/etc/neutron/plugins/ml2/ml2_conf.ini"

sed -i "s/^#type_drivers.*/type_drivers = flat,vlan/g" $ML2_CONF_FILE
sed -i "s/^#tenant_network_types.*/tenant_network_types =/g" $ML2_CONF_FILE
sed -i "s/^#mechanism_drivers.*/mechanism_drivers = linuxbridge/g" $ML2_CONF_FILE
sed -i "s/^#extension_drivers.*/extension_drivers = port_security/g" $ML2_CONF_FILE
sed -i "s/^#flat_networks.*/flat_networks = provider/g" $ML2_CONF_FILE
sed -i "s/^#enable_ipset.*/enable_ipset = True/g" $ML2_CONF_FILE


