# Tag.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sqlite3'

class Tag
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(tagId, description, bookmarkId)
       
        @tagId = tagId
        @description = description
        @bookmarkId = bookmarkId
        
    end
    
    def tagId= tagId
        @tagId = tagId
    end
    def tagId
        return @tagId
    end
    
    def description= description
        @description = description
    end
    def description
        return @description
    end
    
    def bookmarkId= bookmarkId
        @bookmarkId = bookmarkId
    end
    def bookmarkId
        return @bookmarkId
    end
    
end