# Admin.rb
# Author: Luke Suckling
# Author: Ramona Ana-Maria Petre
# Date: 20/05/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/Bookmark'
require_relative '../models/BookmarkReport'

# fetch the admin 'homepage'
# /admin
get '/reports' do
    
    if session[:admin] then
        @bookmarksreports = BookmarkReport.getAll()
        erb :"Admin/reports"
    else
        status 404
    end
end
    
get '/reports/view:reportId' do
    #fetch bookmark object
    @reportId = BookmarkReport.getById(params[:bookmarkId])

    erb :"/Admin/view"
end