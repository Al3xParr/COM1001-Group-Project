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

    def test_new_comment

        success = Comment.newComment("hello", 1, 1);

        assert_equal true, success

        successTwo = Comment.newComment(nil, 1, 1);

        assert_equal false, successTwo
        
    end

    def test_get_all

        comments = Comment.getAll

        comment = comments[0]

        assert_equal 1, comment.commentId
        assert_equal "This is a comment", comment.content
        assert_equal 1, comment.bookmarkId
        assert_equal 1, comment.userId

    end

    def test_get_by_bookmark_id

        comments = Comment.getByBookmarkId(1)
        
        comment = comments[0]

        assert_equal 1, comment.commentId
        assert_equal "This is a comment", comment.content
        assert_equal 1, comment.bookmarkId
        assert_equal 1, comment.userId

    end

    def test_delete_comment

        comments = Comment.getAll()

        for comment in comments

            result = Comment.deleteComment(comment.commentId)

            assert_equal true, result
            
        end

    end

end