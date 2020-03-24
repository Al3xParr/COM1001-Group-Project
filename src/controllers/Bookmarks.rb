# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def getAllBookmarks
    bookmarks = Bookmark.getAll()
end

before do
    @db = SQLITE3::Database.new './database/database.sqlite'
end

# show all avaliable bookmarks
# /bookmarks/all
get '/bookmarks/all' do
    #lists the title and date of creation in order of date of creation
    @TITLE = @db.execute "SELECT title, createdAt FROM bookmarks ORDER BY createdAt ASC"
    erb :"Bookmark/index"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    @SEARCH = session[:search]
    if @SEARCH != ''
        @SEARCH_RESULTS = db.exercute "SELECT title FROM bookmarks WHERE title LIKE " + @SEARCH + " ORDER BY createdAt ASC"
    end
    erb :"Bookmarks/search"
end

#post search form data and perform search using values
post '/bookmarks/search' do
    redirect '/bookmarks/search'    
end

# return edit page for defined bookmark paramter
# /bookmarks/edit?id={bookmark id}
get '/bookmarks/edit' do
    erb :"Bookmarks/edit"
end

# update the defined bookmark with the parsed post data
# /bookmarks/edit
post '/bookmarks/edit' do

end

# view the bookmarks own page
# /bookmarks/view?id={bookmark id}
get '/bookmarks/view' do
    erb :"Bookmarks/view"
end

# create a comment on the bookmark
# returns:
#   the individual view page of the bookmark i.e.
#   /bookmarks/view?id={bookmark id}
post '/bookmarks/comment' do

end