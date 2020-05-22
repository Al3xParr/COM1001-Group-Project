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

    def to_s
        return "Bookmark ID: #{@bookmarkId} | Created at: #{@createdAt} | Title: #{@title} | Description: #{@description} | Resource: #{@resource} | Archived: #{@archived} | User ID: #{@userId}"
    end

    # Create a new bookmark in the databse
    # Returns: bool if operation was successful or not
    def self.newBookmark(title, description, resource, archived, userId)

        query = "INSERT INTO bookmarks('title', 'description', 'resource', 'archived', 'userId', 'createdAt') VALUES(?, ?, ?, ?, ?, ?);"      

        begin
            DB.execute query, title, description, resource, archived, userId, Time.now.inspect
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
            
    def self.searchByTag(tags)
        toReturn = []
        tagIds = []
        tags.each do |t|
            query = "SELECT tagId FROM tags WHERE tag LIKE ? ;"
            result = DB.execute query, "%" + t + "%"
            tagIds.push(result)
        end
            
        bookmarkIds = []
            
        tagIds.each do |b|
            query = "SELECT bookmarkId FROM bookmarks_to_tags WHERE tagId=? ;"
            result = DB.execute query, b
            bookmarkIds.push(result) 
        end
        
        bookmarkIds = bookmarkIds.uniq
        
        bookmarkIds.each do |i|
            result = getById(i)
            if result != nil && result != "" then
                toReturn.push(result) 
            end

        end
                
        return toReturn
        
    end
    
    #searching function for the bookmarks
    def self.searchBy(searchTerm, searchType)
        toReturn = []
        
        #changing the query dependant on the search
        if searchType == "title" then
            query = "SELECT * FROM bookmarks WHERE title LIKE ? ;"
            result = DB.execute query, "%" + searchTerm + "%"
        elsif searchType == "resource" then
            query = "SELECT * FROM bookmarks WHERE resource LIKE ? ;"
            result = DB.execute query, "%" + searchTerm + "%"
            
        elsif searchType == "bookmarkId" then
            query = "SELECT * FROM bookmarks WHERE bookmarkId LIKE ? ;"
            result = DB.execute query, searchTerm
        elsif searchType == "userId" then
            query = "SELECT * FROM bookmarks WHERE userId LIKE ? ;"
            result = DB.execute query, searchTerm
        end
       
        for bookmark in result do
            bookmarkObj = Bookmark.new(bookmark[0], bookmark[1], bookmark[2], bookmark[3], bookmark[4], bookmark[5], bookmark[6])
            toReturn.push(bookmarkObj)
        end
        
        return toReturn
    end
            
    #Returning the rating for a specific bookmark
    #Returns: the average rating and number of times it has been rated
   
    def self.getRatingByBookmarkId(bookmarkId)
      rating = []
      totalRating = 0
      count = 0
      totalRatings = Rating.getByBookmarkId(bookmarkId)
      for j in (0..(totalRatings.length - 1))
        totalRating += totalRatings[j].rating.to_f
        count += 1
      end
      if count == 0 then
        rating[0] = 0
      else
        temp = (totalRating/count*100).to_i
        rating[0] = temp.to_f/100
      end
      rating[1] = count
      return rating
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
    def self.getByTitle
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
    def self.getById(bookmarkId)
        
        query =  "SELECT * FROM bookmarks WHERE bookmarkId=?;"

        result = DB.execute query, bookmarkId
        
        if result == "" || result == nil || result[0] == nil then

            return nil
        else

            result = result[0]

            return Bookmark.new(result[0], result[1], result[2], result[3], result[4], result[5], result[6])
        end

        return nil
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
            
    # Updates bookmark column by setting the description based on bookmarkId
    # Returns: an array of Bookmark object(s)
    def self.updateDescription(desc, bookId)
        
        query =  "UPDATE bookmarks SET description = ? WHERE bookmarkId = ?;"
        result = DB.execute query, desc, bookId
        
        return result
    end
       
    #returning the new title from the edited bookmark
    def self.updateTitle(tit, bookId)
        
        query = "UPDATE bookmarks SET title = ? WHERE bookmarkId = ?;"
        result = DB.execute query, tit, bookId
        
        return result
    end
        
    #updating the resource for the bookmarks after edits
    def self.updateResource(res, bookId)
        
        query = "UPDATE bookmarks SET resource = ? WHERE bookmarkId = ?;"
        result = DB.execute query, res, bookId
        
        return result
    end
end