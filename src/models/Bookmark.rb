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

        
        #This is to handle / convert SQLite 1 / 0 to true and false values
        if archived == 0 then
            @archived = false
        elsif archived == 1 then
            @archived = true
        else
            @archived = archived
        end


        @createdAt = createdAt
        @userId = userId
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
            
            bookmarkObj = Bookmark.new(bookmark[0], bookmark[1], bookmark[2], bookmark[3], bookmark[4], bookmark[5], bookmark[6])
            toReturn.push(bookmarkObj)
            
        end
        
        return toReturn
    end
            
    # Return all the known bookmark  in the database as Bookmark objects
    # Returns: an array of Bookmark objects
    def self.getTitle
        toReturn = []
        
        result = DB.execute "SELECT title, createdAt FROM bookmarks ORDER BY createdAt ASC;"
        
        for bookmark in result do
            
            bookmarkObj = Bookmark.new(nil, bookmark[1], bookmark[2], nil, nil, nil, nil)
            toReturn.push(bookmarkObj)
            
        end
        return toReturn
    end
            
    # Return all the known bookmark IDs in the database as Bookmark objects
    # Returns: an array of Bookmark objects
    def self.getId
        toReturn = []
        
        result = DB.execute "SELECT bookmarkId FROM bookmarks;"
        
        for bookmark in result do
            
            bookmarkObj = Bookmark.new(bookmark[0], nil, nil, nil, nil, nil, nil)
            toReturn.push(bookmarkObj)
            
        end
        return toReturn
    end
            
    # Return all the known bookmark including the search term @SEARCH
    # Returns: an array of Bookmark objects
    def self.search(term)
        toReturn = []
        
        query =  "SELECT title FROM bookmarks WHERE title LIKE ? ORDER BY createdAt ASC;"
        result = DB.execute query, '%' + term + '%'

        for bookmark in result do
            
            bookmarkObj = Bookmark.new(bookmark[0], nil, nil, nil, nil, nil, nil)
            toReturn.push(bookmarkObj)
            
        end
        return toReturn
    end
end