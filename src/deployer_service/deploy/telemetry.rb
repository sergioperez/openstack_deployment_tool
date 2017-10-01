#!/usr/bin/ruby

def deploy_telemetry(ssh)
	puts ssh.exec! ("touch ~/env")
end


