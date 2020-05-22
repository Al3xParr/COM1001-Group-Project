
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
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        Then I should see "Logged in as: admin" within "body"
        When I press "New tag" within "anchor"
       
    Scenario: Commenting the bookmarks 
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I fill in "comment" with "noice" 
        #When I press "Comment"
        #Then I should see "noice"
        
    Scenario: Reporting the bookmarks 
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I follow "Report"
        Then I should be on the report page
        Then I should see "Report Bookmark"
        When I choose "Title" 
        When I fill in "reason" with "faulty bookmark"
        When I press "Report"
        #continue once addition has been made to this page
        
    Scenario: Editing the bookmarks 
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I follow "Edit"
        Then I should be on the edit page
        Then I should see "Edit the Bookmark"
        Then I should see "New Title"
        When I fill in "title" with "Staff payroll 2020"
        Then I should see "New Description"
        When I fill in "edit" with "This is the staff payrol for the year blah blah blah"
        Then I should see "New Resource"
        When I fill in "resource" with "https://some.internal.server/payroll/2020.xlsx/"
        When I press "Update Bookmark"
        Then I should see "Bookmark updated."
        
    Scenario: Favourite bookmark
        Given I am on the login page
        When I fill in "username" with "admin"
        When I fill in "password" with "admin"
        When I press "Login" within "form"
        Then I should be on the bookmark homepage
        When I follow "➔" within "table"
        Then I should be on the view bookmark page
        When I follow "Favourite"
         
        
        
        
        
        
        
        
         
       
         
        
         
          