#!/bin/bash

virt=`egrep -c '(vmx|svm)' /proc/cpuinfo`
NOVA_COMPUTE_CONF_PATH="/etc/nova/nova-compute.conf"

if [ $virt -eq 0 ] 
then
	#If there is no support for hardware acceleration, then use qemu
	echo "No hw acceleration available. Using qemu"
	sed -i "s/virt_type=.*/virt_type=qemu/g" $NOVA_COMPUTE_CONF_PATH
else
	#If there is hw acceleration, then use kvm
	echo "HW acceleration available. Using kvm"
	sed -i "s/virt_type=.*/virt_type=kvm/g" $NOVA_COMPUTE_CONF_PATH
fi

