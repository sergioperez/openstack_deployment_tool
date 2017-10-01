#!/bin/bash

#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#List service components
openstack compute service list
