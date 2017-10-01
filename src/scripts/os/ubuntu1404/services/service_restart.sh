#!/bin/bash

if [ "$1" == "" ]
        then
        echo "Usage: ./restart_service.sh service_name"
else
        service=$1
        echo "Restarting service $service"
        service $service restart
fi
