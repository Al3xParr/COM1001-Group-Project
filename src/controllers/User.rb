# User.rb
# Author: Ramona Ana-Maria Petre
# Date: 20/05/2020

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require_relative '../models/User'

# fetch the admin 'homepage'
# /admin
get '/user' do
    
    if session[:admin] then
       # @users = User.getAll()
        erb :"Admin/user"
    else
        status 404
    end
end
