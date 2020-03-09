# User.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sqlite3'
require 'bcrypt'

class User
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(userId = nil, username = nil, password = nil, admin = nil)
       
        @userId = userId
        @username = username
        @password = password
        @admin = admin
    end
    
    # Set getters and setters for all our properties
    # This allows following functionality
    # newVar = userObj.userId
    # or
    # userObj.userId = 2
    # 
    def userId= userId
        @userId = userId
    end
    def userId
        return @userId
    end
    
    def username= username
        @username = username
    end
    def username
        return @username
    end
    
    def password= password
        @password = password
    end
    def password
        return @password
    end
    
    def admin= admin
        @admin = admin
    end
    def admin 
        return @admin
    end
    
    # Returns: a string represnting the current state of the object
    def toString
        return "#{@userId} #{@username} #{@password} #{@admin}"
    end
    
    # Parse username and associated plane text password
    # Returns true for valid, false for invalid
    def self.authenticate(username, password)
        
        query = "SELECT password FROM users WHERE username = ?;"
        
        result = DB.execute query, username
        
        if result == "" then
            return false
        else
            if passwordCheck(password, result[0][0]) == false then  
                return false
            end
        end
            
        return true     
    end
    
    # Return all the known users in the database as User objects
    # Returns: an array of User objects
    def self.getAll
        
        toReturn = []
        
        result = DB.execute "SELECT * FROM users;"
        
        for user in result do
            
            toObj = User.new(user[0], user[1], user[2], user[3])
            
            toReturn.push(toObj)
            
        end
        
        return toReturn 
    end
    
    # Add a new user to the database
    # Returns: boolean representing success
    def self.newUser(username, password, admin)
        
        query = "INSERT INTO users('username', 'password', 'admin') VALUES(?, ?, ?);"
        
        begin
            DB.execute query, username, User.passwordHash(password), admin
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    # all methods below are private to class User
    private
    
    # Use BCrypt to hash a password
    # Returns: string of hashed password
    def self.passwordHash(toHash)
        
        return BCrypt::Password.create(toHash)
    end
    
    # Use Bcrypt to check a plaintext password against a hashed
    # Returns: boolean of if password and hash match
    def self.passwordCheck(password, hash)
        
        hashCheck = BCrypt::Password.new(hash)
        
        return hashCheck.is_password?(password)
    end
end