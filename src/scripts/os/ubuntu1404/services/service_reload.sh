#!/bin/bash

if [ "$1" == "" ]
        then
        echo "Usage: ./service_reload.sh service_name"
else
        service=$1
        echo "Reloading service $service"
        service $service reload
fi
