Feature: login

    Scenario: Login
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        Then I should see "Logged in as: admin" within "body"
    
    Scenario: Incorrect username
        Given I am on the login page
        When I fill in "username" with "blah"
        When I fill in "password" with "password"
        When I press "Login" within "form"
        Then I should be on the login page
        Then I should see "Username or password isn't correct." within "form"
    
    Scenario: Incorrect password
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "blah"
        When I press "Login" within "form"
        Then I should be on the login page
        Then I should see "Username or password isn't correct." within "form"
        
   Scenario: Logout
       Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        When I follow "Logout"
        Then I should be on the login page
        Then I should see "Log In" within "body"
    