# TestFavourite.rb
# Author: Luke Suckling
# Date: 18/05/2020

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Favourite'
require_relative '../models/User'
require_relative '../models/Bookmark'

class FavouriteTests < Minitest::Test
    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM favourites"
        db.execute "DELETE FROM bookmarks"
        db.execute "DELETE FROM users"
        
        db.execute "INSERT INTO users(username, password, admin) VALUES('Adam', 'apple', 1);"
        db.execute "INSERT INTO bookmarks(createdAt, title, description, resource, archived) VALUES('16 March', 'amazon', 'anything', 'anything', 0);"
        
    end
    
    def test_new_favourite_and_remove_favourite
        
        user = User.getByUsername("Adam")
        bookmark = Bookmark.getAll[0]
        
        result = Favourite.newFavourite(bookmark.bookmarkId, user.userId)
        
        assert_equal true, result
        
        favourites = Favourite.getByUserId(user.userId)
        
        favourite = favourites[0]
        
        assert_equal "amazon", favourite.title
        assert_equal bookmark.bookmarkId, favourite.bookmarkId
        
        resultTwo = Favourite.removeFavourite(bookmark.bookmarkId, user.userId)
        
        assert_equal true, resultTwo
        
    end
    
end