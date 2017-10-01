#!/bin/bash

if [ "$1" == "" ]
	then
	echo "Usage: ./add_repo.sh repo_name"
else
	repo=$1
	echo "Adding repo $repo"
	add-apt-repository $repo
fi
