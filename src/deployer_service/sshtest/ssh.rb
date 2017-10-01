#!/usr/bin/ruby
def test_ssh(ip,user,pass, hostname)

        @file = "/tmp/deployer_tmp#{rand(200000)}"
        @expected = "funciona"
	puts "Checking connectivity with #{hostname}"
        begin
                Net::SSH.start(ip, user, password: pass, :auth_methods => [ 'password' ],:number_of_password_prompts => 0, :timeout => 2) do |ssh|
                        ssh.exec! ("rm #{@file}")
                        ssh.exec! ("echo #{@expected} > #{@file}")
                        @result = ssh.exec! ("cat #{@file}")
                        @result.strip!
                end
        rescue Errno::EHOSTUNREACH
                puts "  Host unreachable"
        rescue Errno::ECONNREFUSED
                puts "  Connection refused"
        rescue Net::SSH::AuthenticationFailed
                puts "  Authentication failure"
                @result = ""
        rescue Net::SSH::ConnectionTimeout
                puts "  Timed out"
        end

        if @result == @expected
                return true
        else
                return false
        end
        @result = ""
end

