#!/bin/bash
echo 'Generating routes for $OPENSTACK_DEPLOYER_PATH'
source ./vars.sh
mkdir $OPENSTACK_DEPLOYER_PATH
rm -rf $OPENSTACK_DEPLOYER_PATH/*
mv scripts/* $OPENSTACK_DEPLOYER_PATH
mv webscripts/ $OPENSTACK_DEPLOYER_PATH

echo "Get fun! :P"

