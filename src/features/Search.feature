Feature: Search Page
    Scenario: body of the page
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Given I am on the search page
        Then I should see "Search bookmarks" 
        
    Scenario: searching a bookmark
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Given I am on the search page
        Then I should see "Search bookmarks" 
        When I fill in "search" with "Staff payroll"
        When I press "Search" within "form"
        Then I should see "Staff payroll 2020"