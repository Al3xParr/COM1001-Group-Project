# User.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sqlite3'
require 'bcrypt'

class User
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(userId = nil, username = nil, password = nil, admin = nil, deleted = nil)
       
        @userId = userId
        @username = username
        @password = password


        #This is to handle / convert SQLite 1 / 0 to true and false values
        if admin == 0 then
            @admin = false
        elsif admin == 1 then
            @admin = true
        else
            @admin = admin
        end
            
        if deleted == 0 then
            @deleted = false
        elsif deleted == 1 then
            @deleted = true
        else
            @deleted = deleted
        end
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
            
    def deleted= deleted
        @deleted = deleted
    end
    def deleted
        return @deleted
    end
    
    # Returns: a string represnting the current state of the object
    def toString
        return "#{@userId} #{@username} #{@password} #{@admin} #{@deleted}"
    end
    
    # Parse username and associated plane text password
    # Returns true for valid, false for invalid
    def self.authenticate(username, password)
        
        query = "SELECT password FROM users WHERE username = ?;"
        
        result = DB.execute query, username

        if result == "" || result == nil || result[0] == nil then
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
        
        result = DB.execute "SELECT * FROM users;"
        
        return packageUsers(result)
        
    end

    # Get a user by their userId
    # Returns: A user object if successful or nil if not
    def self.getById(userId)

        query = "SELECT * FROM users WHERE userId = ?;"

        result = DB.execute query, userId

        return packageUser(result)
        
    end

    # Get a user by their username
    # Returns: A user object if successful or nil if not
    def self.getByUsername(username)

        query = "SELECT * FROM users WHERE username = ?;"

        result = DB.execute query, username

        return packageUser(result)
        
    end
    
    # Get all known deleted users
    # Returns: An array of user objects who've been deleted
    def self.getDeletedUsers()
        
        query = "SELECT * FROM users WHERE deleted = 1;"
        
        return packageUsers(DB.execute query)
    end
            
    def self.setDeleteState(userId, delete)
        
        if delete == true then
            delete = 1
        elsif delete == false then
            delete = 0
        else
            return
        end    
        
        query = "UPDATE users SET deleted=? WHERE userId=?"
        
        begin
            DB.execute query, deleted, userId
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
            
    def self.setAdminState(userId, admin)
        
        if admin == true then
            admin = 1
        elsif admin == false then
            admin = 0
        else
            return
        end
        
        query = "UPDATE users SET admin=? WHERE userId=?"
        
        begin
            DB.execute query, admin, userId
        rescue SQLite3::Exception
            return false
        end
        
        return true
        
    end
            
    
    # Add a new user to the database
    # Returns: boolean representing success
    def self.newUser(username, password, admin, deleted)
        
        query = "INSERT INTO users('username', 'password', 'admin', 'deleted') VALUES(?, ?, ?, ?);"
        
        begin
            DB.execute query, username, User.passwordHash(password), admin, deleted
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    # all methods below are private to class User
    private
    
    # Return array of user objects 
    def self.packageUsers(dbArray)
        
        toReturn = []
        
        for user in dbArray do
            
            toObj = User.new(user[0], user[1], user[2], user[3], user[4])
            
            toReturn.push(toObj)
            
        end
        
        return toReturn
    end
    
    # Return single user from db result
    def self.packageUser(dbArray)
        
        if dbArray == "" || dbArray == nil || dbArray[0] == nil then
            return nil
        else
            dbArray = dbArray[0]
            return User.new(dbArray[0], dbArray[1], dbArray[2], dbArray[3], dbArray[4])
        end

        return nil
        
    end
        
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