require 'socket'      
require 'mysql'
require_relative './bd'

class Server

	def initialize(port)
		@server = TCPServer.open(port)
		@bd = Basedados.new('localhost','root','root','web_tp1_db')
		@clientes_online = Array.new
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
			@bd.bduser(username,lat,long)
			@clientes_online.push(username)
			flag = true
			count=0
				while flag do
					leitura = client.gets.chomp
					if leitura=="T"
						temp = client.gets.chomp
						data = client.gets.chomp
						count = count +1
						@bd.bd_add_temp(username,temp,data)
					else
						if leitura=="R"
							sound = client.gets.chomp
							data2 = client.gets.chomp
							count = count +1
							@bd.bd_add_sound(username,sound,data2)
						else 
							if leitura == "logout"
								flag = false
								@clientes_online.delete(username)
								puts "XDK #{username} desconetou-se com #{count} leituras efetuadas..."
							end
						end
					end
				end
			end
		end              
	end
	
	def menu
		flag = true
		while flag
			puts "\n"
			puts "------- MENU -------"
			puts "1-Listar clientes logados e a sua posicao"
			puts "2-Historico de um sensor"
			puts "3-Sair"
			puts "--------------------"
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
	
	def listar_users
		system('cls')
		#puts @clientes_online
		puts "----- XDK´s online -----"
		@clientes_online.each do |c|
			r=@bd.get_localizacao(c)
			t=r.fetch_row
			puts c+" Latitude: "+t[0]+" Longitude: "+t[1]
		end
		puts "------------------------"
	end
	
	def valores_sensor
		flag = true
		system('cls')
		while flag
			puts "----- Historico XDK -----"
			puts "Insira o nome do cliente:"
			id = gets.chomp
			rs = @bd.validar_xdk(id)
			puts rs
			if(rs[0]=='1')
				flag1 = true
				puts "Cliente valido..."
				puts "-------------------"
				while flag1
					puts "------ Selecionar tipo de sensor ------"
					puts "1-Sensor de Temperatura"
					puts "2-Sensor de Ruido"
					puts "3-Retroceder"
					puts "4-Voltar ao menu principal"
					case gets.chomp
					when '1' 
						puts imprimir_valores_temp(id)
					when '2'
						puts imprimir_valores_sound(id)
					when '3'
						flag1 = false
						system('cls')
					when '4'
						system('cls')
						menu
					end
				end
			else
				puts "Cliente invalido. Tente mais tarde..."
			end
		end
	end
	
	def imprimir_valores_temp(id)
		valores = @bd.get_xdk_temp(id)
		if nil==valores.fetch_row
			puts "Nenhum valor de temperatura encontrado. Tente mais tarde..."
		else
			system('cls')
			aux = @bd.get_xdk_temp(id)
			puts "----- Valores lidos pelo sensor de temperatura do XDK #{id} -----"
			aux.each do |v|
				puts v[0]+" "+v[1]
			end
		end
		puts "---------------------------------------------------------------"
	end
	
	def imprimir_valores_sound(id)
		valores = @bd.get_xdk_sound(id)
		if nil==valores.fetch_row
			puts "Nenhum valor de ruido encontrado. Tente mais tarde..."
		else
			system('cls')
			aux = @bd.get_xdk_sound(id)
			puts "----- Valores lidos pelo sensor de ruido do XDK #{id} -----"
			aux.each do |v|
				puts v[0]+" "+v[1]
			end
		end
		puts "---------------------------------------------------------------"
	end
end

 Signal.trap("INT") { 
	puts "Servidor desligado..."
    server.close
    exit
}
  
server = Server.new(2000)
