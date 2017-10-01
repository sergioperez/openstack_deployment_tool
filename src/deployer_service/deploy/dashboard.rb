#!/usr/bin/ruby


def deploy_dashboard(ssh, hostname)
	puts ssh.exec! ("touch ~/dash")

	puts "[#{hostname}] Deploying dashboard"
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/dashboard/deploy.sh")
	puts "Dashboard deployed at #{hostname}!"
end


