#!/bin/bash
#Install rabbitmq-server
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/packages/install_package.sh rabbitmq-server


#Add openstack user
$OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/config_tools/rabbitmq/configure_user_rabbitmq.sh openstack $RABBIT_PASS

