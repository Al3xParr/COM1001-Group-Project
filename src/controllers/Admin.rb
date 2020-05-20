# Admin.rb
# Alex Parr
# 20/05/2020

require 'sinatra'
require 'sinatra/reloader'


# /admin
get '/admin' do
    if session[:admin] then
        erb :"Admin/index"
    else
        redirect :"bookmarks/all"
    end
end

get '/admin/bookmarkReport' do
    if session[:admin] then
        erb :"Admin/bookmarkReport"
    else
        redirect :"bookmarks/all"
    end
end

get '/admin/userApproval' do
        if session[:admin] then
        erb :"Admin/userApproval"
    else
        redirect :"bookmarks/all"
    end
   
end

get '/admin/userDisable' do
    if session[:admin] then
        erb :"Admin/userDisable"
    else
        redirect :"bookmarks/all"
    end
    
end