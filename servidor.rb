require 'socket'      
require 'mysql'

class Server

	def initialize(port)
		@server = TCPServer.open(port)
		@bd = Mysql.new('localhost','root','root','web_tp1_db')
		#myRange = 0..20
		#log_array = myRange.to_a
		#myArray[10] = 10
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
			long = client.gets.chomp
			puts "XDK #{username} #{lat} #{long} conetou-se..."
			#bd.logarcliente username
			client.puts "Novo XDK conetado"
			#x = @bd.query("insert into xdk values ( 'ola', '35','2')")
			flag = true
				while flag
					leitura = client.gets.chomp
					puts leitura
					if leitura == "logout"
						flag = false
						puts "XDK #{username} desconetou-se..."
					end
				end
			end
		end              
	end
	
	
	
	def menu
		flag = true
		while flag
			puts "\n"
			puts "1-Listar clientes logados e a sua posicao"
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
				@server.close
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
