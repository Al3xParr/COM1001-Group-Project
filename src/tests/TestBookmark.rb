#TestBookmark.rb
#  .Aryan
#  Ramona Petre
require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Bookmark'

class BookmarksTests < Minitest::Test
    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM bookmarks"
        
        db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('18 March', 'apple', 'something', 'something', 1);"
        db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('16 March', 'amazon', 'anything', 'anything', 0);"
        db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('10 March', 'books', 'action','nothing', 1);"
        db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('13 March', 'movies', 'anything', 'none', 0);" 
        
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

    def test_new_bookmark

        resultOne = Bookmark.newBookmark("Hello", "Hello descriptiption", "https://google.co.uk/", 1, 1);

        assert_equal true, resultOne

        resultTwo = Bookmark.newBookmark("Duplicate resource", "Duplicate description", "something", 0, 1);

        assert_equal false, resultTwo

    end

    def test_get_by_id

        bookmarkOne = Bookmark.getById(1)

        assert_equal '18 March', bookmarkOne.createdAt
        assert_equal 'apple', bookmarkOne.title
        assert_equal 'something', bookmarkOne.description
        assert_equal 'something', bookmarkOne.resource
        assert_equal true, bookmarkOne.archived

        bookmarkNegative = Bookmark.getById(-1)

        assert_nil bookmarkNegative

    end

end