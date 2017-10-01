#!/bin/bash

if [ "$1" == "" ]
	then
	echo "Usage: ./add_repository.sh repository_name"
else
	repo=$1
	echo "Adding repo $repo"
	add-apt-repository -y $repo
fi
