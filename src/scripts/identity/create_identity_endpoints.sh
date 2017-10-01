#!/bin/bash

openstack endpoint create --region RegionOne \
  identity public http://controller:5000/v$IDENTITY_API_VERSION

openstack endpoint create --region RegionOne \
  identity internal http://controller:5000/v$IDENTITY_API_VERSION

openstack endpoint create --region RegionOne \
  identity admin http://controller:35357/v$IDENTITY_API_VERSION
