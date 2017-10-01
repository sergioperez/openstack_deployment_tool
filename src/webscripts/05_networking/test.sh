#!/bin/bash
#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#List neutron loaded extensions
neutron ext-list

#List agents
neutron agent-list
