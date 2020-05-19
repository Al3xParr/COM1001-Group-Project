# Favourites.rb
# Author: Luke Suckling
# Date: 19/05/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/Favourite'

get '/favourites' do

    @favourites = Favourite.getByUserId(session[:userId])

    erb :"Favourites/index"
end

get '/favourites/add/:bookmarkId' do

    if session[:loggedIn] then
        
        Favourite.newFavourite(params[:bookmarkId], session[:userId])

    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end

get '/favourites/remove/:bookmarkId' do

    if session[:loggedIn] then

        Favourite.removeFavourite(params[:bookmarkId], session[:userId])

    end

    redirect back
end