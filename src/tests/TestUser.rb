require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/User'

class UserTests < Minitest::Test
    def setup
        
        @db = SQLite3::Database.new 'database.db'
        
        @db.execute "DELETE FROM users"
        
        @db.execute "INSERT INTO users(username, password, admin) VALUES('Adam', 'apple', 1);"
        @db.execute "INSERT INTO users(username, password, admin) VALUES('Jeff', 'amazon', 0);"
        
    end

    def test_new_user
        
        resultBob = User.newUser("Bob", "secure", 0);

        assert_equal true, resultBob

        resultBill = User.newUser("Bill", "password", 1)

        assert_equal true, resultBill

    end

    def test_authenticate_user
        
        resultBob = User.newUser("Bob", "secure12", 0);
        
        successExpected = User.authenticate("Bob", "secure12")

        assert_equal true, successExpected

        successFailure = User.authenticate("Bob", "wrong")

        assert_equal false, successFailure

        successErroneous = User.authenticate(0 , nil)

        assert_equal false, successErroneous

    end

    def test_get_all_users

        users = User.getAll()

        assert_equal 2, users.length

    end

    def test_get_user_by_id

        skip "To do..."

    end

    def test_get_user_by_username

        bob = User.getByUsername("Adam")

        assert_equal "Adam", bob.username
        assert_equal true, bob.admin

        bill = User.getByUsername("Jeff")

        assert_equal "Jeff", bill.username
        assert_equal false, bill.admin

    end

end