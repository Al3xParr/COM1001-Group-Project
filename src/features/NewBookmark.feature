Feature: New Bookmark page
    Scenario: body of the page
        Given I am on the new page
        Then I should see "New Bookmark"
        Then I should see "Please fill out the form below to create a new bookmark"
        
    Scenario: Adding a existing bookmark    
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Given I am on the new page
        When I fill in "title" with "Staff payroll 2020"
        When I fill in "resource" with "https://some.internal.server/payroll/2020.xlsx/"
        When I fill in "description" with "This is the staff payrol for the year blah blah blah"
        When I press "Create Bookmark" within "form"
        Then I should see "Please do not leave any fields blank."