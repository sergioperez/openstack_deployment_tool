#!/bin/bash
openstack --os-auth-url http://controller:35357/v$IDENTITY_API_VERSION \
  --os-project-domain-name default --os-user-domain-name default \
  --os-project-name admin --os-username admin token issue
