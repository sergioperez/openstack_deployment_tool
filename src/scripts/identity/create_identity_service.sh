#!/bin/bash

openstack service create \
	--name keystone --description "OpenStack Identity" identity
