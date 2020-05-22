# TestUser.rb
# Author: Luke Suckling
# Date: 16/03/2020

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

    #Adds new user into the database
    #Should return true because they match the field requirements
    def test_new_user
        
        resultBob = User.newUser("Bob", "secure", 0, 0);

        assert_equal true, resultBob

        resultBill = User.newUser("Bill", "password", 1, 0)

        assert_equal true, resultBill

    end

    #Adds new user into the database
    #Should return true if the user matches the password in the database, and false otherwise or if the fields are not completed as expected
    def test_authenticate_user
        
        resultBob = User.newUser("Bob", "secure12", 0, 0);
        
        successExpected = User.authenticate("Bob", "secure12")

        assert_equal true, successExpected

        successFailure = User.authenticate("Bob", "wrong")

        assert_equal false, successFailure

        successErroneous = User.authenticate(0 , nil)

        assert_equal false, successErroneous

    end

    #Gets all users from the database
    #Should return 2 because there are only 2 users 
    def test_get_all_users

        users = User.getAll()

        assert_equal 2, users.length

    end
    
    #Gets an user by their username
    #Returns true if the username matches and if the user is an admin
    def test_get_user_by_username

        bob = User.getByUsername("Adam")

        assert_equal "Adam", bob.username
        assert_equal true, bob.admin

        bill = User.getByUsername("Jeff")

        assert_equal "Jeff", bill.username
        assert_equal false, bill.admin

    end
    
    #Gets an user from the database by their username, and then deletes the user based on its ID
    #Gets an array of all deleted users
    #Should return true if the first user in the array is deleted and if the username matches
    def test_delete_user
        
        bob = User.getByUsername("Adam")
        
        result = User.setDeleteState(bob.userId, true)
        
        assert_equal true, result
        
        users = User.getDeletedUsers()
        
        adam = users[0]
        
        assert_equal true, adam.deleted
        assert_equal "Adam", adam.username
        
    end
    
    #Gets an user by their username and checks if the user is an admin
    #Makes the user an admin
    #Should return true if the user is now an admin 
    def test_set_admin_state
        
        jeff = User.getByUsername("Jeff")
        
        assert_equal false, jeff.admin
        
        result = User.setAdminState(jeff.userId, true)
        
        assert_equal true, result
        
        jeffTwo = User.getByUsername("Jeff")
        
        assert_equal true, jeffTwo.admin
        
    end
end