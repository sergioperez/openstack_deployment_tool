#!/usr/bin/ruby

def deploy_orchestration(ssh)
	puts ssh.exec! ("touch ~/orches")
end


