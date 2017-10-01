#!/usr/bin/ruby

def deploy_objectstorage(ssh)
	puts ssh.exec! ("touch ~/obj")
end


