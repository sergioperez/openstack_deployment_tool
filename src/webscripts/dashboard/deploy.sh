#!/bin/bash
#Install packages
. $OPENSTACK_DEPLOYER_PATH/dashboard/install_packages.sh

#Configure dashboard #TODO: Configure API versions
$OPENSTACK_DEPLOYER_PATH/dashboard/configure_horizon.sh

#Finalize installation
. $OPENSTACK_DEPLOYER_PATH/dashboard/finalize_installation.sh

