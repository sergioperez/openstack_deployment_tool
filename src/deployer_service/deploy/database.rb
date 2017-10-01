#!/usr/bin/ruby

def deploy_database(ssh)
	puts ssh.exec! ("touch ~/db")
end


