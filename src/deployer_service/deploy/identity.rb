#!/usr/bin/ruby

def deploy_identity(ssh, hostname)
	ssh.exec! ("touch ~/identity")


	puts("[#{hostname}] Deploying identity service") 
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/02_identity/deploy_identity.sh")
	
end
