#!/bin/bash

$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh glance-registry
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/services/service_restart.sh glance-api
