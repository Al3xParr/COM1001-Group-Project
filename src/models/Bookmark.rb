# Bookmark.rb
# Author: Luke Suckling
# Date: 10/03/2020

require 'sqlite3'
require 'bcrypt'

class Bookmark
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(title, description, resource, archived, createdAt, userId)
        
        @title = title
        @description = description
        @resource = resource
        @archived = archived
        @createdAt = createdAt
        @userId = userId
        
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
    
end