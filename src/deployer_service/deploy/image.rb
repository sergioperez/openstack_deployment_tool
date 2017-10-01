#!/usr/bin/ruby

def deploy_image(ssh, hostname)
	puts ssh.exec! ("touch ~/img")

	puts("[#{hostname}] Deploying image service")
        ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/03_image/deploy_image.sh")
end
