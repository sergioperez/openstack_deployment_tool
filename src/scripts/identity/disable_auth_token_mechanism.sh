#!/bin/bash

KEYSTONE_PASTE_FILE="/etc/keystone/keystone-paste.ini"
sed -i 's/ admin_token_auth / /g' $KEYSTONE_PASTE_FILE
echo "Auth token mechanism disabled"


