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

    def self.removeTag(bookmarkId, tagId)
        
        query = "DELETE FROM bookmarks_to_tags WHERE bookmarkId = ? AND tagId = ?;"

        begin
            DB.execute query, bookmarkId, tagId
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    private

    def self.createTag(tag)

        query = "INSERT INTO tags('tag') VALUES(?);"

        begin
            DB.execute query, tag
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    def self.createLink(bookmarkId, tagId)

        query = "INSERT INTO bookmarks_to_tags('bookmarkId', 'tagId') VALUES(?, ?);"

        begin
            DB.execute query, bookmarkId, tagId
        rescue SQLite3::Exception
            return false
        end

        return true
    end

    def self.doesTagExist(tag)

        query = "SELECT * FROM tags WHERE tag=?;"

        result = DB.execute query, tag

        if result == "" || result == nil || result[0] == nil then
            return nil
        else
            return result[0][0]
        end

    end

    def self.doesLinkExist(bookmarkId, tagId)
        
        query = "SELECT * FROM bookmarks_to_tags WHERE bookmarkId = ? AND tagId = ?;"

        result = DB.execute query, bookmarkId, tagId

        if result == "" || result == nil || result[0] == nil then
            return false
        else
            return true
        end

    end
    
end