Feature: Bookmark

     Scenario: body of the page
         Given I am on the bookmark homepage
         Then I should see "All bookmarks"
         
     Scenario: acessing the bookmarks
         Given I am on the bookmark homepage
         When I follow "➔" within "table"
         Then I should be on the view bookmark page
          