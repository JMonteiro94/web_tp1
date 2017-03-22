# a67739--a67740

require 'socket'

class Client
	
	def initialize(server, lat, long)
		@server = server
		@lat = lat
		@long = long
	end
	
	def run
		puts "Nome do XDK:"
		@username= gets.chomp
		@server.puts @username
		@server.puts @lat
		@server.puts @long
		t1 = Thread.new{get_temp}	
		t2 = Thread.new{get_sound}
		t1.join
		t2.join
	end
  
	def get_temp
		temp = rand(-40..40)
		sleep 1
		while true do
			temp+=rand(-5..5)
			@server.puts("T")
			@server.puts temp
			@server.puts Time.now.getutc
			puts("Temperatura: #{temp} C as #{Time.now.getutc}")
			sleep 30
		end
	end
	
	def get_sound
		sound = rand(700)
		while true do
			sound+=rand(-50..50)
			@server.puts("R")
			@server.puts sound
			@server.puts Time.now.getutc
			puts("Ruido: #{sound} db as #{Time.now.getutc}")
			sleep 1
		end
	end
	
	def offline 
		@server.puts "logout"
	end
  
end

con = TCPSocket.open('localhost', 2000)
c1=Client.new(con,9.69,-10.10)

Signal.trap("INT") {
	puts "Cliente a desligar..."
	c1.offline
    exit
}

c1.run


