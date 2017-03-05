require 'socket'      
require 'thread'

class Server

	def initialize(port)
		@server = TCPServer.open(port)
		t1 = Thread.new{menu}	
		t2 = Thread.new{run}
		t1.join
		t2.join
	end
	
	def run
		loop do                         
			Thread.start(@server.accept) do |client|                  
			username = client.gets.chomp
			lat = client.gets.chomp
			puts "XDK #{username} conetou-se..."
			client.puts "Novo XDK conectado"
			listen_user_messages(username, client)
			end
		end              
	end
	
	def listen_user_messages(username, client)
		loop do
			lat = client.gets.chomp
			long = client.get.chomp
			puts "#{lat}"
		end
	end
	
	def menu
		flag = true
		while flag
			puts "\n"
			puts "1-Listar clientes logado e a sua posicao"
			puts "2-Monitorizar um sensor"
			puts "3-Sair"
			case gets.chomp
			when '1'
				puts listar_users
			when '2'
				puts valores_sensor
			when '3'
				flag = false
				puts "Servidor desligado..."
				server.close
			end
		end
	end
	
end

 Signal.trap("INT") { 
	puts "Servidor desligado..."
    server.close
    exit
}
  
server = Server.new(2000)
