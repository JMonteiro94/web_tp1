require 'mysql'

class Basedados

	def initialize(hostname,username,pass,dbnome)
        @bd = Mysql.new(hostname, username,pass, dbnome)  
    end

	def bdclose
		@bd.close
	end
	
	def bduser(username, lat, long)
		r = @bd.query("SELECT count(*) from xdk where username='"+username+"'")
		total = r.fetch_row 
        if(total[0]=='0') 
			x = @bd.query("insert into xdk values ('"+username+"','"+lat+"','"+long+"')")
		end
		#x = @bd.query("insert into xdk values ( 'ola', '35','2')")
	end
	
	def bd_add_temp(username, temp, data)
		x = @bd.query("insert into valores_sensores (temp,data,xdk_username) values ('"+temp+"','#{data}','"+username+"')")
	end

	def bd_add_sound(username, sound, data)
		x = @bd.query("insert into valores_sensores (ruido,data,xdk_username) values ('"+sound+"','#{data}','"+username+"')")
	end
	
	def get_localizacao(username)
		x = @bd.query("Select lat,longi from xdk where username='"+username+"'")
	end
end
