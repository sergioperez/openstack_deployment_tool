#!/bin/bash

#Add the admin role to the glance user and service project
openstack role add --project service --user glance admin
