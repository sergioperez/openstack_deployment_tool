#!/bin/bash

LINUXBRIDGE_CONF_FILE="/etc/neutron/plugins/ml2/linuxbridge_agent.ini"
if [ "$1" == "" ]
then
	echo "Usage ./configure_linuxbridge_agent.sh PROVIDER_INTERFACE_NAME"
	echo "Example: ./configure_linuxbridge_agent.sh eth1"
else
	PROVIDER_INTERFACE_NAME=$1
	sed -i "s/^#physical_interface_mappings.*/physical_interface_mappings = provider:$PROVIDER_INTERFACE_NAME/g" $LINUXBRIDGE_CONF_FILE
	sed -i "s/^#enable_vxlan.*/enable_vxlan = False/g" $LINUXBRIDGE_CONF_FILE
	sed -i "s/^#enable_security_group.*/enable_security_group = True/g" $LINUXBRIDGE_CONF_FILE
	sed -i "s/^#firewall_driver.*/firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver/g" $LINUXBRIDGE_CONF_FILE
fi
