#!/bin/bash 

#- 
#
#	Generates a random password in hexadecimal format
#	using OpenSSL
#
#	Arguments:
#		Password length
#
#	If the length is not specified, then a password of length 10 is generated
#

if [ "$1" -ge "0"  ]
	then
	passlength=$1
else
	passlength=10
fi
	openssl rand -hex $passlength
