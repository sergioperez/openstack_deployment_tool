#!/usr/bin/ruby

def deploy_blockstorage(ssh)
	puts ssh.exec! ("touch ~/bs")
end


