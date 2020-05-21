# Comments.rb
# Author: Luke Suckling
# Date: 08/04/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Comment'

post '/comments/create' do

    if session[:loggedIn] then

        if params[:comment].length >= 4 && params[:comment].length < 1000 then
            Comment.newComment(params[:comment], params[:bookmarkId], session[:userId])
        else
            @commentsError = "Comment needs at be between 4 and 1000 characters."
        end

        redirect "/bookmarks/view/#{params[:bookmarkId]}"
    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"
end

post '/comments/delete' do

    puts params[:commentId]

    result = Comment.deleteComment(params[:commentId])

    puts result

    if result then
        redirect back
    else
        status 500
    end
end