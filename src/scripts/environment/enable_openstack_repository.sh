#!/bin/bash
bash ../os/apt/install_package.sh software-properties-common
bash ../os/apt/enable_openstack_repository.sh $OPENSTACK_REPO_NAME
bash ../os/apt/update_lists.sh
