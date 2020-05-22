# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
require_relative '../models/BookmarkReport'
require_relative '../models/Comment'
require_relative '../models/Tag'
require_relative '../models/Rating'


# show all avaliable bookmarks
# /bookBookmark.getTitle in order of date of creation
get '/bookmarks/all' do
    # gets all info about the bookmark
    @bookmarks = Bookmark.getAll()
    @ratings = []
  
    #ratings for the bookmarks
    for i in (0..(@bookmarks.length - 1))
      @ratings[i] = Bookmark.getRatingByBookmarkId(@bookmarks[i].bookmarkId)
    end
  
  
    erb :"Bookmarks/index"
end

get '/bookmarks/view/:bookmarkId' do

    #fetch bookmark object
    @bookmark = Bookmark.getById(params[:bookmarkId])

    #details for each bookmark
    @user = User.getById(@bookmark.userId)
    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    @comments = Comment.getByBookmarkId(params[:bookmarkId])

    #checking the user is logged in for to see if the bookmark is a favourite
    if session[:loggedIn] then

        @isFavourite = Favourite.isFavourite(params[:bookmarkId], session[:userId])
        @loggedIn = session[:loggedIn]
        
    end

    @rating = Bookmark.getRatingByBookmarkId(params[:bookmarkId])
    
    erb :"/Bookmarks/view"
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    
    @search_results = Bookmark.getAll()
    @ratings = []
  
    for i in (0..(@search_results.length - 1))
      @ratings[i] = Bookmark.getRatingByBookmarkId(@search_results[i].bookmarkId)
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
        elsif @search_option == "Tags"
            @search_results = Bookmark.searchByTag(@search.split(", "))
        end
    end
    @ratings = []
  
    for i in (0..(@search_results.length - 1))
      @ratings[i] = Bookmark.getRatingByBookmarkId(@search_results[i].bookmarkId)
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
        if params[:title] != '' && !params[:title].match(/\s+/)
            @title = Bookmark.updateTitle(params[:title], $BOOKMARK_ID)
        else
            @bookmarkError = "Please enter the form properly."
        end
        if params[:edit] != '' && !params[:edit].match(/\s+/)
            @description = Bookmark.updateDescription(params[:edit], $BOOKMARK_ID)
         else
            @bookmarkError = "Please enter the form properly."    
        end
        if params[:resource] != ''
            @resource = Bookmark.updateResource(params[:resource], $BOOKMARK_ID)
        end
        
        if !@bookmarkError
            @bookmarkSuccess = "Bookmark updated."
        end
        erb :"Bookmarks/edit"
        #redirect "bookmarks/all"
    end
end

#creating a new bookmark page
get '/bookmarks/new' do
    erb :"Bookmarks/new"
end

post '/bookmarks/new' do
  #checking if a user is loaged in
  if session[:loggedIn] != true then
    @bookmarkError = "User not logged in"
    erb :"Bookmarks/new"
  else
    #getting the bookmark information for the new bookmark
    @title = params[:title]
    @resource = params[:resource]
    @description = params[:description]
    @userId = session[:userId]

    if !@title.match(/\s+/) && !@description.match(/\s+/)
      success = Bookmark.newBookmark(@title,@description,@resource,0,@userId)
    else
        @bookmarkError = "Please do not leave any fields blank."
    end
        

    if success then
      redirect "/bookmarks/all"
    else
      if !@bookmarkError
        @bookmarkError = "Unable to create bookmark. Bookmark may already exist"
      end
      erb :"Bookmarks/new"
    end

  end
end

#report form for a bookmark
get '/bookmarks/report/:bookmarkId' do
     
    @bookmark = Bookmark.getById(params[:bookmarkId])
    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    

    erb :"Bookmarks/report"
end
    
#submitting a report form to the admins
post '/bookmarks/report/:bookmarkId' do
    @bookmark = Bookmark.getById(params[:bookmarkId])
    @tags = Tag.getByBookmarkId(params[:bookmarkId])
    
    #parameters aren't empty
    if session[:loggedIn] 
        if ((params[:report_option] == nil && params[:issue] == '' || params[:issue].match(/\s+/)) || (params[:reason] = '' && params[:reason].match(/\s+/)))
            @blankError = "Please properly complete the form."
        else
           
            if params[:report_option] == nil then
                finalIssue = params[:issue]
            else
                finalIssue = params[:report_option]
            end

            #submitting the report
            success = BookmarkReport.newReport(@bookmark.bookmarkId, session[:userId], finalIssue, params[:reason])

            if success then
                redirect "bookmarks/view/#{@bookmark.bookmarkId}"
            else
                @reportError = "Internal server error when registering bookmark report."
            end
        end
    else
        @reportError = "User not logged in."
    end

    erb :"Bookmarks/report"
end

#adding the ratings to the bookmark for each user
post 'bookmarks/ratings/add' do

    #checks before submitting the report
    if session[:loggedIn] != true then
      redirect "/bookmarks/view/#{params[:bookmarkId]}"
    else
      result = Rating.newRating(params[:bookmarkId], session[:userId], params[:rate])

      redirect "/bookmarks/view/#{params[:bookmarkId]}"
    end
end