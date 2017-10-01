#!/bin/bash
#Being done manually at the ruby script

#Cleanup of host names before adding them
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/remove_host.sh compute
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/remove_host.sh controller

#Adding hostnames
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/add_host.sh 192.168.1.180 controller
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/add_host.sh 192.168.1.190 compute

