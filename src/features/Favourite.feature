Feature: Favourites page

    Scenario: body of the page
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Given I am on the bookmark homepage
        When I follow "Favourites"
        Then I should be on the favourites page
        Then I should see "Your favourites"

   Scenario: removing a favourites
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Given I am on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I follow "Favourite"
        Given I am on the favourites page
        Then I should not see "Staff payroll 2019"