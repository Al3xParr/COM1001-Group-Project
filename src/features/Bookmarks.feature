Feature: Bookmark

     Scenario: opening a bookmark
         Given I am on the bookmark homepage
         When I follow "goto" within "table"
         Then I should be on the view bookmark page
          