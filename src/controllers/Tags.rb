# Tags.rb
# Author: Luke Suckling
# Date: 15/04/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/Tag'

#adding a tag to the bookmark
post '/tags/add' do

    #validation
    if session[:loggedIn] then
        
        if params[:tag] != "" && !params[:tag].match(/\s+/) then
          result = Tag.newTag(params[:tag].downcase, params[:bookmarkId])
        end

        Tag.clearUnusedtags()
    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"
end
# add tag from most common tags section
get '/tags/add/:tagId/:tag/:bookmarkId' do

    if session[:loggedIn] then

        if params[:tag] != "" && !params[:tag].match(/\s+/) then
            result = Tag.newTag(params[:tag].downcase, params[:bookmarkId])
        end

    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end

#removing a tag from the cross
get '/tags/delete/:tagId/:bookmarkId' do

    if session[:loggedIn] then

        result = Tag.removeTag(params[:bookmarkId], params[:tagId])

    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end