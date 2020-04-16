# Tags.rb
# Author: Luke Suckling
# Date: 15/04/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/Tag'

post '/tags/add' do

    result = Tag.newTag(params[:tag], params[:bookmarkId])

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end

get '/tags/delete/:tagId/:bookmarkId' do

    result = Tag.removeTag(params[:bookmarkId], params[:tagId])

    redirect "/bookmarks/view/#{params[:bookmarkId]}"

end