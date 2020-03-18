require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Bookmark'

class BookmarksTests < Minitest::Test
    def setup
        
        @db = SQLite3::Database.new 'database.db'
        
        @db.execute "DELETE FROM bookmarks"
        
        @db.execute "INSERT INTO bookmarks(bookmarkId,createdAt, title, description, resource, archived, userId) VALUES(1,'18 March', 'apple', 'something',
                     'something', 1,1);"

 @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('16 March', 'amazon', 'anything',
                     'anything', 0);"
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('10 March', 'books', 'action',
                     'nothing', 1);"
        @db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('13 March', 'movies', 'anything',
                     'none', 0);" 
        
    end

    def test_get_all_bookmarks

        bookmarks = Bookmark.getAll()

        assert_equal 4, bookmarks.length
        

    end

    def test_get_all_bookmark_details
        
        array= []
        array.push(Bookmark.new(1,'18 March', 'apple', 'something','something', 1,1))
        bookmarks = Bookmark.getAll()
        
        assert_equal array, puts(bookmarks[0])

    end

end