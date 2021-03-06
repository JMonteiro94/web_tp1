require 'mysql'

class Basedados

	def initialize(hostname,username,pass,dbnome)
        @bd = Mysql.new(hostname, username,pass, dbnome)  
    end

	def bdclose
		@bd.close
	end
	
	def bduser(username, lat, long)
		r = @bd.query("SELECT count(username) from xdk where username='"+username+"'")
		rs = r.fetch_row 
        if(rs[0]=='0') 
			x = @bd.query("insert into xdk values ('"+username+"','"+lat+"','"+long+"')")
		end
	end
	
	def bd_add_temp(username, temp, data)
		x = @bd.query("insert into valores_sensores (temp,data,xdk_username) values ('"+temp+"','#{data}','"+username+"')")
	end

	def bd_add_sound(username, sound, data)
		x = @bd.query("insert into valores_sensores (ruido,data,xdk_username) values ('"+sound+"','#{data}','"+username+"')")
	end
	
	def get_localizacao(username)
		x = @bd.query("SELECT lat,longi from xdk where username='"+username+"'")
	end
	
	def validar_xdk(id)
		r = @bd.query("SELECT count(username) from xdk where username='"+id+"'")
		rs = r.fetch_row
		return rs
	end
	
	def get_xdk_temp(id)
		x = @bd.query("SELECT temp,data from valores_sensores where temp IS NOT NULL and xdk_username='"+id+"'")
		return x
	end
	
	def get_xdk_sound(id)
		x = @bd.query("SELECT ruido,data from valores_sensores where ruido IS NOT NULL and xdk_username='"+id+"'")
		return x
	end
end
