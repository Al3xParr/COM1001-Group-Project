# Favourite.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sqlite3'

class Favourite
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(favouriteId, bookmarkId, userId)
        
        @favouriteId = favouriteId
        @bookmarkId = bookmarkId
        @userId = userId
        
    end
    
    def favouriteId= favouriteId
        @favouriteId = favouriteId
    end
    def favouriteId
        return @favouriteId
    end
    
    def bookmarkId= bookmarkId
        @bookmarkId = bookmarkId
    end
    def bookmarkId
        return @bookmarkId
    end
    
    def userId= userId
        @userId = userid
    end
    def userId
        return @userId
    end
    
end