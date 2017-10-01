#!/usr/bin/ruby

require 'net/ssh'
require 'json'

require_relative('deploy/identity')
require_relative('deploy/blockstorage')
require_relative('deploy/compute')
require_relative('deploy/dashboard')
require_relative('deploy/database')
require_relative('deploy/environment')
require_relative('deploy/image')
require_relative('deploy/networking')
require_relative('deploy/objectstorage')
require_relative('deploy/orchestration')
require_relative('deploy/sharedfilesystem')
require_relative('deploy/telemetry')
require_relative('sshtest/ssh')

##Main (server)

#Autoflush output
STDOUT.sync = true

def install_services(my_hash)
	@sshok = true 
	my_hash.each do |node|
		@res = test_ssh(node[1]["ip"],node[1]["username"],node[1]["password"], node[0])
		if @res == false
			@sshok = false
		end
	end


	#Generating keys for the deployment
	@keys = generate_keys(30)

	@threads = []
	if @sshok
       	my_hash.each do |node|
	@threads << Thread.new {
		begin
		@n = node[1]
		Net::SSH.start(@n["ip"], @n["username"], password: @n["password"], :number_of_password_prompts => 0) do |ssh|

			nodelist = Array.new
			#Set hostnames
			my_hash.each do |node|
				newnode = Hash.new
				newnode["ip"] = node[1]["ip"]
				newnode["hostname"] = node[0]
				nodelist << newnode
		        end

			@n=node[1]
                        @man_ip = @n["management_ip"]
			@prov_ip = @n["ip"] #TODO Now using 'ip'
                        @hostname = node[0]


                	deploy_environment(ssh, nodelist, @n["type"], node[1]["ip"], @hostname, @keys)

			if node[1]["services"].include?("identity")
				deploy_identity(ssh, @hostname)
			end
			if node[1]["services"].include?("image")
				deploy_image(ssh, @hostname)
			end
			if node[1]["services"].include?("compute")
				deploy_compute(ssh, @hostname, @man_ip)
			end
			if node[1]["services"].include?("compute-controller")
				deploy_compute_controller(ssh, @hostname, @man_ip)
			end
			if node[1]["services"].include?("networking")
				deploy_networking(ssh, @hostname, "1", "eth1")
			end
			if node[1]["services"].include?("networking-controller")
				deploy_networking_controller(ssh, @hostname, 1, "eth1")
			end
			if node[1]["services"].include?("dashboard")
				deploy_dashboard(ssh, @hostname)
			end
			if node[1]["services"].include?("blockstorage")
				deploy_blockstorage(ssh)
			end
			if node[1]["services"].include?("sharedfilesystem")
				deploy_sharedfilesystem(ssh)
			end
			if node[1]["services"].include?("objectstorage")
				deploy_objectstorage(ssh)
			end
			if node[1]["services"].include?("orchestration")
				deploy_orchestration(ssh)
			end
			if node[1]["services"].include?("telemetry")
				deploy_telemetry(ssh)
			end
			if node[1]["services"].include?("database")
				deploy_database(ssh)
			end

			puts ""
			puts "[#{@hostname}[OpenStack keys]"
			puts ssh.exec!("cat ~/keys.sh")
		end #End Net::SSH
		rescue Errno::EHOSTUNREACH
			puts "  Host unreachable"
		rescue Errno::ECONNREFUSED
			puts "  Connection refused"
		rescue Net::SSH::AuthenticationFailed
			puts "  Authentication failure"
		rescue Net::SSH::ConnectionTimeout
			puts "  Timed out"

		end #End begin
	}#Close thread
	end #End "for each node"
		@threads.each { |thr| thr.join }
		return 0;
	else #If we received the argument saying that the ssh connection is not ok
		puts ("There is a problem connecting with one of the nodes")
		return -1;
	end
end

while 1
	my_json = STDIN.readline.strip
	my_hash = JSON.parse my_json

	puts ""
	puts "[O] Starting installation"
	res = install_services(my_hash)
	puts "[X] Installation finished" if res == 0
	puts "[X] Installation failed" if res == -1
end
