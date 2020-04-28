# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
require_relative '../models/Comment'
require_relative '../models/Tag'

@search_options = ['Ti' => 'Title', 'Ta' => 'Tags', 'B' => 'Bookmark ID', 'U' => 'User ID']

# show all avaliable bookmarks
# /bookBookmark.getTitle in order of date of creation
get '/bookmarks/all' do
    # gets all info about the bookmark
    @bookmarks = Bookmark.getAll()

    erb :"Bookmarks/index"
end

get '/bookmarks/view/:bookmarkId' do

    #fetch bookmark object
    @bookmark = Bookmark.getById(params[:bookmarkId])

    @user = User.getById(@bookmark.userId)

    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    
    @comments = Comment.getByBookmarkId(params[:bookmarkId])

    erb :"/Bookmarks/view"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    erb :"Bookmark/search"
end

#post search form data and perform search using values
post '/bookmarks/search' do

    session[:search] = params[:search]

    @search_option = params[:search_option]

    @search = session[:search] #takes the search work from the search form

    #if search form is not empty
    if @search != ''
        if @search_option == "Title"
            
            @search_results = Bookmark.searchByTitle(@search) 
#         elsif @search_option == "Tags"
#             @search_results = Bookmark.searchByTags(@search)
        elsif @search_option == "Bookmark ID"
            @search_results = Bookmark.searchByBookmarkId(@search)
        elsif @search_option == "User ID"
            @search_results = Bookmark.searchByUserId(@search)
        end
    end
    erb :"Bookmarks/search_results"  
end

# return edit page for defined bookmark paramter
# /bookmarks/edit?id={bookmark id}
get '/bookmarks/edit/:bookmarkId' do
    session[:bookmarkId] = params[:bookmarkId]
    $BOOKMARK_ID = session[:bookmarkId]
    erb :"Bookmarks/edit"
end


# update the defined bookmark with the parsed post data
# /bookmarks/edit
post '/bookmarks/edit/:bookmarkId' do
    # assigned to variable in case we want to display edited
    # somewhere in the future as confirmation page
    if session[:loggedIn] != true then
        @bookmarkError = "User not logged in."
        erb :"Bookmarks/edit"
    else
        if params[:title] != ''
            @title = Bookmark.updateTitle(params[:title], $BOOKMARK_ID)
        end
        if params[:edit] != ''
            @description = Bookmark.updateDescription(params[:edit], $BOOKMARK_ID)
        end
        if params[:resource] != ''
            @resource = Bookmark.updateResource(params[:resource], $BOOKMARK_ID)
        end
        
        @bookmarkSuccess = "Bookmark updated."
        erb :"Bookmarks/edit"
        #redirect "bookmarks/all"
    end
end

#creating a new bookmark page
get '/bookmarks/new' do
    erb :"Bookmarks/new"
end

post '/bookmarks/new' do
  
  if session[:loggedIn] != true then
    @bookmarkError = "User not logged in"
    erb :"Bookmarks/new"
  else
    @title = params[:title]
    @resource = params[:resource]
    @description = params[:description]
    @userId = session[:userId]

    success = User.newBookmark(@title,@description,@resource,0,@userId)

    if success then
      @bookmarkSuccess = "Bookmark successfully created"
    else
      @bookmarkError = "Unable to create bookmark. Bookmark may already exist"
    end

    erb :"Bookmarks/new"
  end
end

# view the bookmarks own page
# /bookmarks/view?id={bookmark id}
get '/bookmarks/view/:bookmarkId' do
    @view_bookmark_row_titles = ["Created at: ", "Title: ", "Description: ", "Resource: ", "Archived: ", "User ID: "]
    @view_bookmark = Bookmark.getInfo(params[:bookmarkId])
    @view_bookmark_length = (0...@view_bookmark.length).to_a
    erb :"Bookmarks/view"
end

# create a comment on the bookmark
# returns:
#   the individual view page of the bookmark i.e.
#   /bookmarks/view?id={bookmark id}
post '/bookmarks/comment' do

end