# Bookmark.rb
# Author: Luke Suckling
# Date: 10/03/2020

require 'sqlite3'
require 'bcrypt'

class Bookmark
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(bookmarkId, createdAt, title, description, resource, archived, userId)
        
        @bookmarkId = bookmarkId
        @title = title
        @description = description
        @resource = resource
        @archived = archived
        @createdAt = createdAt
        @userId = userId
);
    end
    
    def bookmarkId= bookmarkId
        @bookmarkId = bookmarkId
    end
    def bookmarkId
        return @bookmarkId
    end
    
    def title= title
        @title = title
    end
    def title
        return @title
    end
    
    def description= description
        @description = description
    end
    def description
        return @description
    end
    
    def resource= resource
        @resource = resource
    end
    def resource
        return @resource
    end
    
    def archived= archived
        @archived = archived
    end
    def archived
        return @archived
    end
    
    def createdAt= createdAt
        @createdAt = createdAt
    end
    def createdAt
        return @createdAt
    end
    
    def userId= userId
        @userId = userId
    end
    def userId
        return @userId
    end
    
    # Return all the known bookmarks in the database as Bookmark objects
    # Returns: an array of Bookmark objects
    def self.getAll
        
        toReturn = []
        
        result = DB.execute "SELECT * FROM bookmarks;"
        
        for bookmark in result do
            
            bookmarkObj = Bookmark.new(user[0], user[1], user[2], user[3], user[4], user[5], user[6])
            toReturn.push(bookmarkObj)
            
        end
        
        return toReturn
    end
    
end