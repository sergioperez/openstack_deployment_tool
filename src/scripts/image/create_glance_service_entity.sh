#!/bin/bash

#Create glance service entity
openstack service create --name glance \
  --description "OpenStack Image" image

