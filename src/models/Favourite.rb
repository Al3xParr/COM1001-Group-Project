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
    
    # Get all favourited bookmarks associated with the userId
    # Returns: array of bookmark objects
    def self.getByUserId(userId)
        
        query = "SELECT
                    favourites.userId,
                    favourites.bookmarkId,
                    bookmarks.title,
                    bookmarks.description
                FROM
                    favourites
                INNER JOIN bookmarks ON favourites.bookmarkId = bookmarks.bookmarkId
                WHERE
                    favourites.userId = ?;"
        
        result = DB.execute query, userId
        
        toReturn = []
        
        for fav in result
            
            bookmarkObj = Bookmark.new(fav[1], nil, fav[2], fav[3], nil, nil, fav[0])
            
            toReturn.push(bookmarkObj)
            
        end
        
        return toReturn
    end
    
    # Create a favourite between a user and a bookmark
    # Returns: if operation was successful
    def self.newFavourite(bookmarkId, userId)
        
        query =  "INSERT INTO favourites('bookmarkId', 'userId') VALUES(?,?);"
        
        begin
            DB.execute query, bookmarkId, userId
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    # Remove a favourite between a bookmark and a userId
    # Returns: if operation was successful
    def self.removeFavourite(bookmarkId, userId)
        
        query =  "DELETE FROM favourites WHERE bookmarkId=? AND userId=?;"
        
        begin
            DB.execute query, bookmarkId, userId
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end

    def self.isFavourite(bookmarkId, userId)

        query = "SELECT * FROM favourites WHERE bookmarkId=? AND userId=?;"

        result = DB.execute query, bookmarkId, userId
        
        if result.length == 0 then
            return false
        else
            return true
        end

    end
end