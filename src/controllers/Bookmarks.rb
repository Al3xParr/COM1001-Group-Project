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

@BOOKMARK_ID = Bookmark.getAllId

# show all avaliable bookmarks
# /bookBookmark.getTitle in order of date of creation
get '/bookmarks/all' do
    # gets all info about the bookmark
    @TITLE = Bookmark.getAll
    # numbers each bookmark
    @TITLE_LENGTH = (0...@TITLE.length).to_a
    erb :"Bookmark/index"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    erb :"Bookmark/search"
end

#post search form data and perform search using values
post '/bookmarks/search' do
    session[:search] = params[:search] 
    session[:bookmarkId] = params[:bookmarkId]
    @SEARCH = session[:search] #takes the search work from the search form
    if @SEARCH != '' #if search form is not empty
        @SEARCH_RESULTS = Bookmark.search(@SEARCH) 
        @SEARCH_LENGTH = (0...@SEARCH_RESULTS.length).to_a
    end
    erb :"Bookmark/search_results"  
end

# return edit page for defined bookmark paramter
# /bookmarks/edit?id={bookmark id}
get '/bookmarks/edit' do
    erb :"Bookmark/edit"
end

# update the defined bookmark with the parsed post data
# /bookmarks/edit
post '/bookmarks/edit' do
    session[:edit] = params[:edit]
    session[:bookmarkId] = params[:bookmarkId]
    @BOOKMARK = session[:bookmarkId]
    @DESCRIPTION = session[:edit]
    @UPDATED = Bookmark.updateDescription(@DESCRIPTION, @BOOKMARK)
    #erb :"Bookmark/edit_results"
    redirect "bookmarks/all"
end




# view the bookmarks own page
# /bookmarks/view?id={bookmark id}
get '/bookmarks/view' do
    erb :"Bookmark/view"
end

# create a comment on the bookmark
# returns:
#   the individual view page of the bookmark i.e.
#   /bookmarks/view?id={bookmark id}
post '/bookmarks/comment' do

end