# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
set :bind, '0.0.0.0'
set :views, '../views'
enable :sessions

# show all avaliable bookmarks
# /bookBookmark.getTitle in order of date of creation
get '/bookmarks/all' do
    #$TITLE = ["APPLE", "BANANA", "PEAR"]
    # gets all info about the bookmark
    $TITLE = Bookmark.getAll
    # numbers each bookmark
    $TITLE_LENGTH = (0...$TITLE.length).to_a
    erb :"Bookmark/index"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    @SEARCH = session[:search] #takes the search work from the search form
    if @SEARCH != '' #if search form is not empty
        @SEARCH_RESULTS =  Bookmark.search(@SEARCH) 
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
    @BOOKMARK = session[:bookmarkId]
    @DESCRIPTION = session[:edit]
    @UPDATED = Bookmark.updateDescription(@DESCRIPTION, @BOOKMARK)
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