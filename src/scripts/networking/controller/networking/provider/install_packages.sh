#!/bin/bash

$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh neutron-server 
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh neutron-plugin-ml2
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh neutron-linuxbridge-agent
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh neutron-dhcp-agent
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh neutron-metadata-agent

