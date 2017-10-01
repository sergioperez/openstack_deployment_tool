#!/bin/bash

conf_path="/etc/mysql/conf.d/openstack.cnf"

if [ "$1" == "" ]
	then
	echo "Usage ./file bind_address"
else
	#Set MariaDB configurations
	rm $conf_path
	echo "[mysqld]" >> $conf_path
	echo "bind-address = $1" >> $conf_path
	echo "default-storage-engine = innodb" >> $conf_path
	echo "innodb_file_per_table" >> $conf_path
	echo "max_connections = 4096" >> $conf_path
	echo "collation-server = utf8_general_ci" >> $conf_path
	echo "character-set-server = utf8" >> $conf_path

	echo "Configuration saved at $conf_path"
	
fi
