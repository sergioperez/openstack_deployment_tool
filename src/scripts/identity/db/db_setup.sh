#!/bin/bash

DATABASE_SCRIPT_FILE="$OPENSTACK_DEPLOYER_PATH/identity/db/db.sql"

if [ "$1" == "" ]
        then
        echo "Usage: ./db_setup.sh root_db_password"
else
	#Replace the password of the sql script with the one we are using
	sed -i "s/KEYSTONEPASS/$KEYSTONE_DBPASS/g" $DATABASE_SCRIPT_FILE
        mysql -u root --password="$1" < $DATABASE_SCRIPT_FILE
fi
