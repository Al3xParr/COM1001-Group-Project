# Comment.rb
# Author: Luke Suckling
# Date: 10/03/2020

require 'sqlite3'

class Comment
    
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
    
end