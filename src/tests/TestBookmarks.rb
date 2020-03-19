require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Bookmark'

class BookmarksTests < Minitest::Test
    def setup
        
        @db = SQLite3::Database.new 'database.db'
        
        @db.execute "DELETE FROM bookmarks"
        
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('18 March', 'apple', 'something', 'something', 1);"
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('16 March', 'amazon', 'anything', 'anything', 0);"
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('10 March', 'books', 'action','nothing', 1);"
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('13 March', 'movies', 'anything', 'none', 0);" 
        
    end

    def test_get_all_bookmarks

        bookmarks = Bookmark.getAll()

        assert_equal 4, bookmarks.length
        
    end

    def test_get_all_bookmark_details
        
        bookmarks = Bookmark.getAll()

        bookmark = bookmarks[0]
        
        assert_equal '18 March', bookmark.createdAt
        assert_equal 'apple', bookmark.title
        assert_equal 'something', bookmark.description
        assert_equal 'something', bookmark.resource
        assert_equal true, bookmark.archived

    end

end