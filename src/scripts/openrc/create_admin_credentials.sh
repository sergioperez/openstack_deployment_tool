#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] || [ "$4" == "" ]
then
	echo "Usage: ./create_credentials.sh 
		 os_project_domain_name
		 os_user_domain_name
		 os_project_name
		 os_username
		 os_password
		 os_auth_url
		 os_identity_api_version
		 os_image_api_version"
else
	CREDENTIALS_FILE=$OPENSTACK_DEPLOYER_PATH/openrc/$4-openrc	
	touch $CREDENTIALS_FILE
	echo "export OS_PROJECT_DOMAIN_NAME=$1" >> $CREDENTIALS_FILE 
	echo "export OS_USER_DOMAIN_NAME=$2" >> $CREDENTIALS_FILE
	echo "export OS_PROJECT_NAME=$3" >> $CREDENTIALS_FILE
	echo "export OS_USERNAME=$4" >> $CREDENTIALS_FILE
	echo "export OS_PASSWORD=$5" >> $CREDENTIALS_FILE
	echo "export OS_AUTH_URL=$6" >> $CREDENTIALS_FILE
	echo "export OS_IDENTITY_API_VERSION=$7" >> $CREDENTIALS_FILE
	echo "export OS_IMAGE_API_VERSION=$8" >> $CREDENTIALS_FILE

fi
