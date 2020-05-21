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
    
post '/reports/delete' do
    @bookmarksreports = params[:reportId]
    BookmarkReport.deleteReport(@bookmarksreports)
    redirect '/reports'
end