#!/bin/bash
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh nova-api
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh neutron-server
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh neutron-linuxbridge-agent
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh neutron-dhcp-agent
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh neutron-metadata-agent
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh neutron-13-agent
