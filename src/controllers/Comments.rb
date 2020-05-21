# Comments.rb
# Author: Luke Suckling
# Date: 08/04/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Comment'

post '/comments/create' do

    result = Comment.newComment(params[:comment], params[:bookmarkId], session[:userId])


    if result then
        redirect "/bookmarks/view/#{params[:bookmarkId]}"
    else
        status 500
    end

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