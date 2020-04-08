# Comment.rb
# Author: Luke Suckling
# Date: 10/03/2020

require 'sqlite3'

class Comment

    DB = SQLite3::Database.new 'database.db'
    
    def initialize(commentId, content, bookmarkId, userId)
        
        @commentId = commentId
        @content = content
        @bookmarkId = bookmarkId
        @userId = userId
        
    end
    
    def commentId= commentId
        @commentId = commentId
    end
    def commentId
        return @commentId
    end
    
    def content= content
        @content = content
    end
    def content
        return @content
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

    def self.newComment(content, bookmarkId, userId)
        
        query = "INSERT INTO comments('content', 'bookmarkId', 'userId') VALUES(?, ?, ?);"

        DB.execute query, content, bookmarkId, userId

        begin
            
        rescue SQLite3::Exception
            return false
        end

        return true

    end

    def self.getAll()

        toReturn = []
        
        result = DB.execute "SELECT * FROM comments;"
        
        for comment in result do
            
            commentObj = Comment.new(comment[0], comment[1], comment[2], comment[3])
            toReturn.push(commentObj)
            
        end
        
        return toReturn

    end

    def self.getByBookmarkId(bookmarkId)

        toReturn = []
        
        query = "SELECT * FROM comments WHERE bookmarkId=?;"

        result = DB.execute query, bookmarkId
        
        for comment in result do
            
            commentObj = Comment.new(comment[0], comment[1], comment[2], comment[3])
            toReturn.push(commentObj)
            
        end
        
        return toReturn

    end
    
end