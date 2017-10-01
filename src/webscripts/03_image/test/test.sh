#!/bin/bash

#Source admin credentials
. $OPENSTACK_DEPLOYER_PATH/openrc/admin-openrc

#Download image
wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

#Upload image to the image service
openstack image create "cirros" \
  --file cirros-0.3.4-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public

#List images
openstack image list
