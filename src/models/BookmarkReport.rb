# Report.rb
# Author: Luke Suckling
# Date: 15/05/2020

require 'sqlite3'

class BookmarkReport
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(reportId, bookmarkId, userId, issue, description)
        
        @reportId = reportId
        @bookmarkId = bookmarkId
        @userId = userId
        @issue = issue
        @description = description
        
    end
    
    def reportId= reportId
        @reportId = reportId
    end
    def reportId
        return @reportId
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
    
    def issue= issue
        @issue = issue
    end
    def issue
        return @issue
    end
    
    def description= description
        @description = description
    end
    def description
        return @description
    end
    
    # Create a new report record in the database
    # Returns: boolean if successful
    def self.newReport(bookmarkId, userId, issue, description)
        
        query = "INSERT INTO bookmark_reports('bookmarkId', 'userId', 'issue', 'description') VALUES(?,?,?,?);"
        
        begin
            DB.execute query, bookmarkId, userId, issue, description
        rescue SQLite3::Exception
            return false
        end
        
        return true
    end
    
    # Get all known bookmark reports
    # Returns: an array of BookmarkReport objects
    def self.getAll()
        
        toReturn = []
        
        query = "SELECT * FROM bookmark_reports"
        
        result = DB.execute query
        
        for report in result do
            
            reportObj = BookmarkReport.new(report[0], report[1], report[2], report[3], report[4])
            toReturn.push(reportObj)
            
        end
        
        return toReturn
    end
    
    #returning the bookmarks by Id
    def self.getById(bookmarkId)
        
        query =  "SELECT * FROM bookmark_reports WHERE bookmarkId=?;"

        result = DB.execute query, bookmarkId
        
        if result == "" || result == nil || result[0] == nil then

            return nil
        else

            result = result[0]

            return BookmarkReport.new(result[0], result[1], result[2], result[3], result[4])
        end

        return nil
    end
    
    # Remove a bookmark report from the database
    # Returns: boolean representing success
    def self.deleteReport(reportId)

        query = "DELETE FROM bookmark_reports WHERE reportId=?;"

        puts reportId
        
        begin
            DB.execute query, reportId
        rescue SQLite3::Exception
            return false
        end
        
        return true

    end
end