#!/usr/bin/ruby


def deploy_compute(ssh, hostname, management_ip)
	puts ssh.exec! ("touch ~/compu")

	puts ("[#{hostname}] Deploying compute service at compute node")
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/04_compute/deploy_compute.sh #{management_ip}")
end

def deploy_compute_controller(ssh, hostname, management_ip)
	puts ssh.exec!("touch ~/compu_control")

	puts("[#{hostname}] Installing and configuring compute service at controller")
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/04_compute/deploy_controller.sh #{management_ip}")

end


