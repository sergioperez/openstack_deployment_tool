#!/bin/bash

chrony_file="/etc/chrony/chrony.conf"
echo "NTP Servers removal : Removing all servers"
sed -i "/^server/d" $chrony_file
echo "Removed all servers from $chrony_file"
