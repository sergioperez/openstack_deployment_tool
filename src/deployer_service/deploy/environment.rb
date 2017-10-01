#!/usr/bin/ruby
require('securerandom')
require_relative('vars.rb')

NTP_SERVER="hora.rediris.es"


def deploy_environment(ssh, hash_nodes, type, ip, hostname, keys)
	puts "[#{hostname}] Deploying environment"

	#Removing any previous script
	ssh.exec!("rm *.sh")
	#Get installer files and initialize the structure
	puts ssh.exec!("cd /root/ && wget #{FILES_URL}/release1.tar.gz -O release1.tar.gz")
	puts ssh.exec!("tar -zxf release1.tar.gz")
	#Generating keys
	store_keys(ssh, keys)

	ssh.exec!(". generate_routes.sh")

	
	puts "[#{hostname}]Setting hostname"
	ssh.exec!("echo #{hostname} > /etc/hostname")


	puts "[#{hostname}]Adding hostnames"
	hash_nodes.each do |node|
		#Todo: remove previous hostnames?
		puts ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/remove_host.sh #{node['hostname']}")
		#Add hostnames
		puts ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/os/$OPENSTACK_OS_VERSION/hosts/add_host.sh #{node['ip']} #{node['hostname']}")
	end


	#Configure ntp
	if type == "controller"
		@ntpserver = NTP_SERVER
	else
		@ntpserver = "controller"
	end
		puts "[#{hostname}]Installing Chrony"
		ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/02_ntp.sh #{@ntpserver}");
	
	#Install OpenStack packages
	puts "[#{hostname}]Installing OpenStack packages"
	ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/03_install_openstack.sh cloud-archive:mitaka")


	if type == "controller"
		puts "[#{hostname}]Installing MariaDB"	
		ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/controller/04_mysql.sh #{ip}")

		puts "[#{hostname}]Installing MongoDB"
		ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/controller/05_mongodb.sh #{ip}")

		puts "[#{hostname}]Installing RabbitMQ"
		ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/controller/06_rabbitmq.sh")

		puts "[#{hostname}]Installing Memcached"
		ssh.exec!(". ~/vars.sh && . $OPENSTACK_DEPLOYER_PATH/webscripts/01_environment/controller/07_memcached.sh #{ip}")

	end
end

def generate_keys quantity
	@keys = Array.new
	for i in 0..quantity
		@keys << SecureRandom.hex[0..20]
	end
	
	return @keys
end

def store_keys(ssh, keys)
	@keynames = Array.new
	@keynames << "ROOT_DBPASS"
	@keynames << "ADMIN_PASS"
	@keynames << "CEILOMETER_DBPASS"
	@keynames << "CEILOMETER_PASS"
	@keynames << "CINDER_DBPASS"
	@keynames << "CINDER_PASS"
	@keynames << "DASH_DBPASS"
	@keynames << "DEMO_PASS"
	@keynames << "GLANCE_DBPASS"
	@keynames << "GLANCE_PASS"
	@keynames << "HEAT_DBPASS"
	@keynames << "HEAT_DOMAIN_PASS"
	@keynames << "HEAT_PASS"
	@keynames << "KEYSTONE_DBPASS"
	@keynames << "NEUTRON_PASS"
	@keynames << "NEUTRON_DBPASS"
	@keynames << "NOVA_DBPASS"
	@keynames << "NOVA_PASS"
	@keynames << "RABBIT_PASS"
	@keynames << "SWIFT_PASS"
	@keynames << "KEYSTONE_ADMINTOKEN"
	@keynames << "METADATA_SECRET"
	
	ssh.exec!("rm ~/keys.sh")
	@keynames.each_with_index do |keyname, index|
		ssh.exec!("echo #{keyname}=#{keys[index]} >> ~/keys.sh")
	end
end
