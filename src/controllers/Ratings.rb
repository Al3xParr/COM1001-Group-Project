# Ratings.rb
# Author: Nathan Mitchell
# Date: 20/04/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Rating'

#adding ratings to the bookmarks
post '/ratings/add' do
    
    #checking the rate has a value
    if params[:rate] == nil then
      redirect "/bookmarks/view/#{params[:bookmarkId]}"
    end
      
    #adding a rate to the bookmark
    rate = Integer(params[:rate])
    if session[:loggedIn] != true then
      @ratingError = "User not logged in"
      redirect "/bookmarks/view/#{params[:bookmarkId]}"
    else
      result = Rating.newRating(params[:bookmarkId], session[:userId], rate)
   
      if result then
          redirect "/bookmarks/view/#{params[:bookmarkId]}"
      else
          status 500
      end
    end
    
end
