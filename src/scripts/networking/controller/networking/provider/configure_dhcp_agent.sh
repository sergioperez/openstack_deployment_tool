#!/bin/bash

DHCP_AGENT_CONF_FILE="/etc/neutron/dhcp_agent.ini"

sed -i "s/^#interface_driver.*/interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver/g" $DHCP_AGENT_CONF_FILE
sed -i "s/^#dhcp_driver.*/dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq/g" $DHCP_AGENT_CONF_FILE
sed -i "s/^#enable_isolated_metadata.*/enable_isolated_metadata = True/g" $DHCP_AGENT_CONF_FILE


