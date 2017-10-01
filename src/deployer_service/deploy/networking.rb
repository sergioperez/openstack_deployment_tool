#!/usr/bin/ruby


def deploy_networking(ssh, hostname, network_type, prov_iface_name)
	puts ssh.exec! ("touch ~/net")

	puts ("[#{hostname}] Deploying networking service at networking node (NetType:#{network_type})") 
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/05_networking/deploy_networking.sh #{network_type} #{prov_iface_name}")
end


def deploy_networking_controller(ssh, hostname, network_type, prov_iface_name)
	puts ssh.exec! ("touch ~/net_contro")

	puts("[#{hostname}] Configuring networking service at controller (NetType:#{network_type})")
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/05_networking/deploy_controller.sh #{network_type} #{prov_iface_name}")
end
