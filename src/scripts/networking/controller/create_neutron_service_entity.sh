#!/bin/bash
openstack service create --name neutron \
  --description "OpenStack Networking" network
