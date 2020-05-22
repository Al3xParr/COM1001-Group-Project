# Rating_test.rb
# Author: Luke Suckling
# Date: 22/05/2020

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/SignupRequest'

class SignupRequestTests < Minitest::Test
    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM signup_requests"

        db.execute "INSERT INTO signup_requests(userId, reason, time) VALUES('1','let me in','18 March');"
        db.execute "INSERT INTO signup_requests(userId, reason, time) VALUES('2','needed for work','18 May');"
        db.execute "INSERT INTO signup_requests(userId, reason, time) VALUES('4','hello','22 April');"
    end

    def test_new_request

        success = SignupRequest.newRequest(3, "Intern");

        assert_equal true, success

        allRequests = SignupRequest.getAll()

        assert_equal 4, allRequests.length

    end

    def test_get_by_user_id

        request = SignupRequest.getByUserId(4)

        assert request != nil

    end

    def test_get_all

        allRequests = SignupRequest.getAll()

        assert_equal 3, allRequests.length

    end

    def test_delete_by_user_id

        success = SignupRequest.deleteById(4)

        assert_equal true, success

        allRequests = SignupRequest.getAll()

        assert_equal 2, allRequests.length


    end
    
end