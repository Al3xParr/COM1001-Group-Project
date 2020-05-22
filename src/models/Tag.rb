# Tag.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sqlite3'

class Tag
    
    DB = SQLite3::Database.new 'database.db'
    
    def initialize(tagId, tag)
       
        @tagId = tagId
        @tag = tag
        
    end
    
    def tagId= tagId
        @tagId = tagId
    end
    def tagId
        return @tagId
    end
    
    def tag= tag
        @tag = tag
    end
    def tag
        return @tag
    end

    # Get the tags associated with the parsed bookmarkId
    # Returns: an array of Tag objects
    def self.getAll()
        toReturn = []

        query = "SELECT * FROM tags;"

        result = DB.execute query

        for tag in result do

            newTag = Tag.new(tag[0], tag[1])
            toReturn.push(newTag)

        end

        return trimTagArray(toReturn, 10)
    end
    def self.getByBookmarkId(bookmarkId)

        toReturn = []

        query = "SELECT
                    bookmarks_to_tags.bookmarkId,
                    bookmarks_to_tags.tagId,
                    tags.tag
                FROM
                    bookmarks_to_tags
                INNER JOIN tags ON bookmarks_to_tags.tagId = tags.tagId
                WHERE
                    bookmarks_to_tags.bookmarkId = ?;"

        result = DB.execute query, bookmarkId

        for tag in result do

            newTag = Tag.new(tag[1], tag[2])
            toReturn.push(newTag)

        end

        return toReturn
    end

    # Append a tag to the specified bookmark
    # Returns: bool if successful or not
    def self.newTag(tag, bookmarkId)

        tagId = Tag.doesTagExist(tag)

        if tagId != nil then

            if Tag.doesLinkExist(bookmarkId, tagId) == false then

                Tag.createLink(bookmarkId, tagId)

            else

                return false
                
            end
        else

            Tag.createTag(tag)
            tagId = doesTagExist(tag)
            Tag.createLink(bookmarkId, tagId)

        end

        return true
    end

    # Remove an associated tag from the specified bookmark
    # Returns: bool if successful or not
    def self.removeTag(bookmarkId, tagId)
        
        query = "DELETE FROM bookmarks_to_tags WHERE bookmarkId = ? AND tagId = ?;"

        begin
            DB.execute query, bookmarkId, tagId
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    # Remove all unused tags.
    # Only called when a new tag is added
    def self.clearUnusedtags()

        query = "SELECT * FROM tags;"

        result = DB.execute query

        # iterate all tags and check for link in many to many table; if not delete
        for tag in result do

            tagId = tag[0]

            queryTag = "SELECT * FROM bookmarks_to_tags WHERE tagId=?;"

            result = DB.execute queryTag, tagId

            if result.length < 1 then
                
                deleteQuery = "DELETE FROM tags WHERE tagId=?;"
                DB.execute deleteQuery, tagId

            end
        end

    end

    # All methods below are private to class Tag
    private

    # Creats a tag in the tags table w/o linking it to a bookmark in the bookmarks_to_tags table
    # Returns: bool if successful
    def self.createTag(tag)

        query = "INSERT INTO tags('tag') VALUES(?);"

        begin
            DB.execute query, tag
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    # Creates link between a bookmarkId and tagId in the bookmarks_to_tags table for many to many relationship
    # Returns bool if successful
    def self.createLink(bookmarkId, tagId)

        query = "INSERT INTO bookmarks_to_tags('bookmarkId', 'tagId') VALUES(?, ?);"

        begin
            DB.execute query, bookmarkId, tagId
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    # Verifies if a tag exists in the tags table
    # Returns bool definiing if tag exists
    def self.doesTagExist(tag)

        query = "SELECT * FROM tags WHERE tag=?;"

        result = DB.execute query, tag

        if result == "" || result == nil || result[0] == nil then
            return nil
        else
            return result[0][0]
        end

    end

    # Verifies if a link exists between a tag and a bookmark
    # Returns bool defining if link exists
    def self.doesLinkExist(bookmarkId, tagId)
        
        query = "SELECT * FROM bookmarks_to_tags WHERE bookmarkId = ? AND tagId = ?;"

        result = DB.execute query, bookmarkId, tagId

        if result == "" || result == nil || result[0] == nil then
            return false
        else
            return true
        end

    end

    def self.trimTagArray(array, maxLength)

        if array.length > maxLength then
            array = array.first(maxLength)
        end

        return array
    end
    
end