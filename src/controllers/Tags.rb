# Tags.rb
# Author: Luke Suckling
# Date: 15/04/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/Tag'

post '/tags/add' do

    if session[:loggedIn] then
        
        if params[:tag] != "" then
          result = Tag.newTag(params[:tag], params[:bookmarkId])
        end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"
    
    end
end

get '/tags/delete/:tagId/:bookmarkId' do

    if session[:loggedIn] then

        result = Tag.removeTag(params[:bookmarkId], params[:tagId])

    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end