# Team 12 

## How to run the application
In order to run the program, you need to write in the terminal: `cd project/src`, and then `ruby app.rb`.

## How to log in to the website
In order to log in to the website, we have the following details: if you wish to log in as an admin, the username and password are both 
"admin"; if you wish to log in as a normal user, the username and password are both "user". 

## What can you do as a visitor, user and admin
If you're not logged in, you can only see the bookmarks and search for a particular bookmark. In order to comment, rate, edit, report or make
a bookmark a favourite, you need to be logged in as an user. If you're not an user, you can simply click on the Sign Up and create an account
which then needs to be approved by an admin. 
As an admin, you can manage the accounts, either approve new accounts or delete them, as well as make an account an admin, and manage the
bookmark reports.

## Running tests
### Cucumber 
navigate to `/src` and run `rake feature`
### Minitest
navigate to `/src/tests` and run `ruby alltest.rb`