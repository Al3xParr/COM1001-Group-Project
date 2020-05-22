# Rating_test.rb
# Author: Luke Suckling
# Date: 22/05/2020

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Rating'

class RatingTests < Minitest::Test
    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM ratings"

        db.execute "INSERT INTO ratings(bookmarkId, userId, rating) VALUES('1','5','5');"
    end

    # Ensure rating overwrites existing ratings and also adds brand new ratings
    def test_new_bookmark

        # Updating existing ratings
        result = Rating.newRating(1, 5, 4);

        assert_equal true, result

        updatedRating = Rating.getByBookmarkId(1);

        assert_equal 4, updatedRating[0].rating

        #Brand new ratings
        resultTwo = Rating.newRating(2, 5, 3);

        assert_equal true, resultTwo

    end

    # Ensure test_get_bookmarks gets all
    def test_get_bookmark

        existingBookmark = Rating.getByBookmarkId(1);

        assert_equal 1, existingBookmark.length
        assert_equal 5, existingBookmark[0].rating

    end
    
end