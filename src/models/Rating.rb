# Rating.rb
# Author: Luke Suckling
# Date: 15/05/2020

require 'sqlite3'

class Rating
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(ratingId, bookmarkId, userId, rating)
        
        @ratingId = ratingId
        @bookmarkId = bookmarkId
        @userId = userId
        @rating = rating
        
    end
    
    def ratingId= ratingId
        @ratingId = ratingId
    end
    def ratingId
        return @ratingId
    end
    
    def bookmarkId= bookmarkId
        @bookmarkId = bookmarkId
    end
    def bookmarkId
        return @bookmarkId
    end
    
    def userId= userId
        @userId = userId
    end
    def userId
        return @userId
    end
    
    def rating= rating
        @rating = rating
    end
    def rating
        return @rating
    end
    
    def self.newRating(bookmarkId, userId, rating)
        
        query = "INSERT INTO ratings('bookmarkId', 'userId', 'rating') VALUES(?,?,?);"
        
        begin
            DB.execute query, bookmarkId, userId, rating
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    # Return an array of all known rating objects linked to the parsed bookmarkId
    # bookmarkId: the bookmarkId for which returned rating objects are linked to
    # Returns: an array of Rating objects
    def self.getByBookmarkId(bookmarkId)
        
        toReturn = []
        
        query = "SELECT * FROM ratings WHERE bookmarkId= ? ;"
        
        result = DB.execute query, bookmarkId
        
        for rating in result do
            
            ratingObj = Rating.new(rating[0], rating[1], rating[2], rating[3])
            toReturn.push(ratingObj)
            
        end
        
        return toReturn
    end
    
end