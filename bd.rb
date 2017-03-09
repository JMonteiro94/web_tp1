require 'mysql'

class bd
	def initialize(hostname,username,pass,dbnome)
        @db = Mysql.new(hostname, username,pass, dbnome)  
    end
	
	def dbclose
		@db.close
	end
	
end
	