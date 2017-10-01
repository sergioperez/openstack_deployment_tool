#!/bin/bash
openstack service create --name nova \
  --description "OpenStack Compute" compute
