# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
require_relative '../models/Comment'
require_relative '../models/Tag'
require_relative '../models/Rating'

# show all avaliable bookmarks
# /bookBookmark.getTitle in order of date of creation
get '/bookmarks/all' do
    # gets all info about the bookmark
    @bookmarks = Bookmark.getAll()
    @ratings = []
  
    for i in (0..(@bookmarks.length - 1))
      @ratings[i] = Bookmark.getRatingByBookmarkId(@bookmarks[i].bookmarkId)
    end
  
  
    erb :"Bookmarks/index"
end

get '/bookmarks/view/:bookmarkId' do

    #fetch bookmark object
    @bookmark = Bookmark.getById(params[:bookmarkId])

    @user = User.getById(@bookmark.userId)

    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    
    @comments = Comment.getByBookmarkId(params[:bookmarkId])
  
    @rating = Bookmark.getRatingByBookmarkId(params[:bookmarkId])
  
    erb :"/Bookmarks/view"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    
    @search_results = Bookmark.getAll()
    @ratings = []
  
    for i in (0..(@search_results.length - 1))
      @ratings[i] = Bookmark.getRatingByBookmarkId(@search_results[i])
    end
    erb :"Bookmarks/search"
end

#post search form data and perform search using values
post '/bookmarks/search' do

    
    session[:search] = params[:search]

    @search_option = params[:search_option]

    @search = session[:search] #takes the search work from the search form
    @search_results = []
    #if search form is not empty
    if @search != '' then
        if @search_option == "Title"
            @search_results = Bookmark.searchBy(@search, "title") 
        elsif @search_option == "BookmarkID"
            @search_results = Bookmark.searchBy(@search, "bookmarkId")
        elsif @search_option == "UserID"
            @search_results = Bookmark.searchBy(@search, "userId")
        elsif @search_option == "source"
            @search_results = Bookmark.searchBy(@search, "resource")
        end
    end
    erb :"Bookmarks/search"  
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

    success = Bookmark.newBookmark(@title,@description,@resource,0,@userId)

    if success then
      @bookmarkSuccess = "Bookmark successfully created"
      erb :"Bookmarks/index"
    else
      @bookmarkError = "Unable to create bookmark. Bookmark may already exist"
      erb :"Bookmarks/new"
    end

  end
end
    
get '/bookmarks/report/:bookmarkId' do
      
    @bookmark = Bookmark.getById(params[:bookmarkId])
    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    

    erb :"Bookmarks/report"
end
    
post '/bookmarks/report/:bookmarkId' do
    @bookmark = Bookmark.getById(params[:bookmarkId])
    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    
    if session[:loggedIn] 
        if params[:report_option] == '' && params[:issue] == '' || params[:reason] == ''
            @blankError = "Please properly complete the form."
        else
            @reportSuccess = "Report successfully submitted"
            @report_option = params[:report_option]
            @issue = params[:issue]
            @description = params[:reason]
        end
    else
        @reportError = "User not logged in."
    end
    erb :"Bookmarks/report"
end