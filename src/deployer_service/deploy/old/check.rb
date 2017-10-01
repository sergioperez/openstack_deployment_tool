#!/usr/bin/ruby

def check(ssh, hostname)
	#Download check.sh
        puts "[#{hostname}]Downloading check.sh"
        #Go to /root
        puts ssh.exec!("cd")
        puts ("[#{hostname}]Downloading check file")
        puts ssh.exec!("wget --quiet #{CHECK_FILE}")
        puts "[#{hostname}]Running check"
        puts ssh.exec!(". check.sh #{RELEASE_FILE}")
end
