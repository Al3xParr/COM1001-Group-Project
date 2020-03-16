require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/User'

class UserTests < Minitest::Test
    def setup
        @db = SQLite3::Database.new 'database.db'
    end

    def test_new_user
        
        resultBob = User.newUser("Bob", "secure", 0);

        assert_equal true, resultBob

        resultBill = User.newUser("Bill", "password", 1)

        assert_equal true, resultBill

    end

    def test_authenticate_user

        successExpected = User.authenticate("Bob", "secure")

        assert_equal true, successExpected

        successFailure = User.authenticate("Bob", "wrong")

        assert_equal false, successFailure

        successErroneous = User.authenticate(0 , nil)

        assert_equal false, successErroneous

    end

    def test_get_all_users

        users = User.getAll()

        puts users.class
        puts users[0].class

        assert_equal 2, users.length

    end

    def test_get_user_by_id

        skip "To do..."

    end

    def test_get_user_by_username

        bob = User.getByUsername("Bob")

        assert_equal "Bob", bob.username
        assert_equal false, bob.admin

        bill = User.getByUsername("Bill")

        assert_equal "Bill", bill.username
        assert_equal true, bill.admin

    end

end