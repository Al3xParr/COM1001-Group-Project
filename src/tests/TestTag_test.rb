# TestTag.rb
# Author: Luke Suckling
# Date: 16/04/2020

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Tag'

class TagTests < Minitest::Test

    def setup
        db = SQLite3::Database.new 'database.db'

        db.execute "DELETE FROM bookmarks_to_tags"
        db.execute "DELETE FROM tags"

        db.execute "INSERT INTO tags(tag) VALUES('Finance');"

    end

    #reliant on nothing
    def test_new_tag

        resultOne = Tag.newTag("Payroll", 1);

        assert_equal true, resultOne

        resultTwo = Tag.newTag("Finance", 1);

        assert_equal true, resultTwo

        resultThree = Tag.newTag("Finance", 1);

        assert_equal false, resultThree

    end

    #reliant on new tag
    def test_get_by_bookmark_id

        resultCreated = Tag.newTag("Payroll", 1);

        assert_equal true, resultCreated

        results = Tag.getByBookmarkId(1);

        result = results[0]

        assert_equal "Payroll", result.tag

        assert_equal 1, results.length

    end

    #reliant on new tag and get by bookmark id
    def test_remove_tag

        resultCreated = Tag.newTag("Payroll", 1);

        assert_equal true, resultCreated

        results = Tag.getByBookmarkId(1);

        result = results[0]

        resultRemoved = Tag.removeTag(1, result.tagId)

        assert_equal true, resultRemoved

    end

end