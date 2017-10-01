#!/bin/bash

DATABASE_SCRIPT_FILE="$OPENSTACK_DEPLOYER_PATH/networking/controller/db/db.sql"


if [ "$1" == "" ]
        then
        echo "Usage: ./db_setup.sh root_db_password"
else
	sed -i "s/NEUTRONDBPASS/$NEUTRON_DBPASS/g" $DATABASE_SCRIPT_FILE
        mysql -u root -p"$1" < "$OPENSTACK_DEPLOYER_PATH/networking/controller/db/db.sql"
fi
