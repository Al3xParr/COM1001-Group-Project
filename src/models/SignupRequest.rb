# SignupRequest.rb
# Author: Luke Suckling
# Date: 19/05/2020

require 'sqlite3'

class SignupRequest
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(requestId, userId, reason, time)
        
        @requestId = requestId
        @userId = userId
        @reason = reason
        @time = time
        
    end
    
    def requestId= requestId
        @requestId = requestId
    end
    def requestId
        return @requestId
    end
    
    def userId= userId
        @userId = userId
    end
    def userId
        return @userId
    end
    
    def reason= reason
        @reason = reason
    end
    def reason
        return @reason
    end
    
    def time= time
        @rating = time
    end
    def time
        return @time
    end
    
    def self.newRequest(userId, reason)
        
        query = "INSERT INTO signup_requests('userId', 'reason', 'time') VALUES(?,?,?);"
        
        begin
            DB.execute query, userId, reason, Time.now.inspect
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    def self.getAll()
        
        toReturn = []
        
        query = "SELECT * FROM signup_requests;"
        
        result = DB.execute query
        
        for request in result do
            
            requestObj = SignupRequest.new(request[0], request[1], request[2], request[3])
            toReturn.push(requestObj)
            
        end
        
        return toReturn
    end
    
end