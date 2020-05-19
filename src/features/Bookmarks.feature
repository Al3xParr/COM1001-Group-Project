Feature: All Bookmark

     Scenario: body of the page
         Given I am on the bookmark homepage
         Then I should see "All bookmarks"
         
     Scenario: acessing the bookmarks
         Given I am on the bookmark homepage
         When I follow "➔" within "table"
         Then I should be on the view bookmark page
         
     Scenario: Inside bookmark page
         Given I am on the view bookmark page
         Then I should see "Description" 
         Then I should see "Resource"
         Then I should see "Tags"
         Then I should see "Comments"
         Then I should see "Author"
    
    
    Scenario: Adding a new tag to the bookmark
        Given I am on the login page
        When I fill in "username" with "luke"
        When I fill in "password" with "password"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        Then I should see "Logged in as: luke" within "body"
        When I press "New tag" within "anchor"
       
    Scenario: Commenting the bookmarks 
        Given I am on the login page
        When I fill in "username" with "luke"
        When I fill in "password" with "password"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I fill in "comment" with "noice" 
        When I press "Comment"
        Then I should see "noice"
        
         
       
         
         
         
          