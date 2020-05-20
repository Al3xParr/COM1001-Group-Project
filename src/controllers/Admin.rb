# Admin.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
require_relative '../models/BookmarkReport'

# fetch the admin 'homepage'
# /admin
get '/admin' do
    
    if session[:admin] then
        @bookmarksreports = BookmarkReport.getAll()
        erb :"Admin/reports"
    else
        status 404
    end
end
    
get '/admin/view:reportId' do
    #fetch bookmark object
    @reportId = BookmarkReport.getById(params[:bookmarkId])

    erb :"/Admin/view"
end