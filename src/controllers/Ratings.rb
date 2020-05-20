# Ratings.rb
# Author: Nathan Mitchell
# Date: 20/04/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Rating'

post '/ratings/add' do
    
    rate = Integer(params[:rate])
    if session[:loggedIn] != true then
      @ratingError = "User not logged in"
      redirect "/bookmarks/view/#{params[:bookmarkId]}"
    else
      result = Rating.newRating(params[:bookmarkId], session[:userId], rate)
   
      if result then
          redirect "/bookmarks/view/#{params[:bookmarkId]}"
      else
          #status 500
      end
    end
    
end
