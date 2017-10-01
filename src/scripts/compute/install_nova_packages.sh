#!/bin/bash
$OPENSTACK_DEPLOYER_PATH/os/ubuntu/apt/install_package.sh nova-api
$OPENSTACK_DEPLOYER_PATH/os/ubuntu/apt/install_package.sh nova-conductor
$OPENSTACK_DEPLOYER_PATH/os/ubuntu/apt/install_package.sh nova-consoleauth
$OPENSTACK_DEPLOYER_PATH/os/ubuntu/apt/install_package.sh nova-novncproxy
$OPENSTACK_DEPLOYER_PATH/os/ubuntu/apt/install_package.sh nova-scheduler
