# Comments.rb
# Author: Luke Suckling
# Date: 08/04/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Comment'

#creating a comment for the bookmark
post '/comments/create' do

    if session[:loggedIn] then
        
        #validation checks on the comments
        if params[:comment].length >= 4 && params[:comment].length < 1000 then
            
            Comment.newComment(params[:comment].strip, params[:bookmarkId], session[:userId])
        else
            @commentsError = "Comment needs at be between 4 and 1000 characters."
        end

        redirect "/bookmarks/view/#{params[:bookmarkId]}"
    end

    redirect "/bookmarks/view/#{params[:bookmarkId]}"
end

#action on deleting a comment
post '/comments/delete' do
        
    if session[:loggedIn] then

        result = Comment.deleteComment(params[:commentId])

        if result then
            redirect back
        else
            status 500
        end
        
    end
end