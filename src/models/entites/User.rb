require_relative '../DbProvider'

class User
    
    DB = DbProvider.getTable(:users)
    
    def initialize(userId = nil, username = nil, password = nil, admin = nil)
       
        @userId = userId
        @username = username
        @password = password
        @admin = admin  
        
    end
    
    def self.getAll
        
        return DB.all
        
    end
    
end