# Favourites.rb
# Author: Luke Suckling
# Date: 19/05/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/Favourite'

#getting the favourites for that user
get '/favourites' do

    @favourites = Favourite.getByUserId(session[:userId])

    erb :"Favourites/index"
end

#adding a favourites to that bookmark list
get '/favourites/add/:bookmarkId' do

    if session[:loggedIn] then
        
        Favourite.newFavourite(params[:bookmarkId], session[:userId])

    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end

#removing a favourite from the list
get '/favourites/remove/:bookmarkId' do

    if session[:loggedIn] then

        Favourite.removeFavourite(params[:bookmarkId], session[:userId])

    end

    redirect back
end