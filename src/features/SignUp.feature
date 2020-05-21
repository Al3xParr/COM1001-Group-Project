
Feature: Sign Up page
     Scenario: body of the page
        Given I am on the sign up page
        Then I should see "Enter details to sign up for an account."
        
   Scenario: making a new account
        Given I am on the sign up page
        Then I should see "Username"
        When I fill in "username" with "aryan"
        Then I should see "Password"
        When I fill in "password" with "password"
        Then I should see "Re-enter Password"
        When I fill in "repassword" with "password"
        Then I should see "Reason"
        When I fill in "reason" with "i am a new user"
        When I press "Sign Up" within "form"
        Then I should see "Username already exists" within "form"
