# TestComment.rb
# Author: Luke Suckling
# Date: 10/04/2020

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Comment'

class CommentTests < Minitest::Test

    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM comments"

        db.execute "INSERT INTO comments(content, bookmarkId, userId) VALUES('This is a comment', '1', '1');"
        db.execute "INSERT INTO comments(content, bookmarkId, userId) VALUES('This is the second comment', '1', '2');"
        db.execute "INSERT INTO comments(content, bookmarkId, userId) VALUES('A third comment', '2', '1');"
        
    end

    #Add two comments into the database, one which has all the fields completed as expected and the other with a "nil" field
    #Should return true for the first comment and false for the other
    def test_new_comment

        success = Comment.newComment("hello", 1, 1);

        assert_equal true, success

        successTwo = Comment.newComment(nil, 1, 1);

        assert_equal false, successTwo
        
    end

    #Gets the first comment from the database, with ID = 1, content = "This is a comment.", bookmarkId = 1, userId = 1
    #Should return true for all the tests
    def test_get_all

        comments = Comment.getAll

        comment = comments[0]

        assert_equal 1, comment.commentId
        assert_equal "This is a comment", comment.content
        assert_equal 1, comment.bookmarkId
        assert_equal 1, comment.userId

    end

    #Gets the first comment from an array of comments that are under the bookmark with ID = 1
    #Should return true for all of the tests
    def test_get_by_bookmark_id

        comments = Comment.getByBookmarkId(1)
        
        comment = comments[0]

        assert_equal 1, comment.commentId
        assert_equal "This is a comment", comment.content
        assert_equal 1, comment.bookmarkId
        assert_equal 1, comment.userId

    end

    #Gets all the comments from the database and deletes all the comments
    #Should return true for all of the comments
    def test_delete_comment

        comments = Comment.getAll()

        for comment in comments

            result = Comment.deleteComment(comment.commentId)

            assert_equal true, result
            
        end

    end

end