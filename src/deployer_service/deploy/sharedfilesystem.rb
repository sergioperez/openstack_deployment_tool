#!/usr/bin/ruby

def deploy_sharedfilesystem(ssh)
	puts ssh.exec! ("touch ~/sfs")
end


