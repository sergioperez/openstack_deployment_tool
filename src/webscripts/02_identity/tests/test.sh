#!/bin/bash

#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#Request auth token
openstack token issue
