#!/bin/bash
openstack --os-auth-url http://controller:5000/v$IDENTITY_API_VERSION \
  --os-project-domain-name default --os-user-domain-name default \
  --os-project-name demo --os-username demo token issue
