# a67739--a67740

require 'socket'
require 'thread'

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
		@server.puts("T #{temp} #{Time.now}")
		while true do
			sleep 1
			temp+=rand(-5..5)
			@server.puts("T #{temp} #{Time.now}")
			puts("Temperatura: #{temp} C as #{Time.now}")
		end
	end
	
	def get_sound
		sound = rand(700)
		@server.puts("Ruido: #{sound} db as #{Time.now}")
		while true do
			sleep 1
			sound+=rand(-50..50)
			@server.puts("R #{sound} #{Time.now}")
			puts("Ruido: #{sound} db as #{Time.now}")
		end
	end
	
	def offline 
		@server.puts "logout"
	end
	
end

con = TCPSocket.open('localhost', 2000)
c1=Client.new(con,69, 25)

Signal.trap("INT") { 
	puts "Cliente a desligar..."
	c1.offline
    exit
}

c1.run


