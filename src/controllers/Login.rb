# Login.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/User'

# return the login page
get '/login' do
<<<<<<< HEAD
    
=======
>>>>>>> 98c5a79b8bc9b6b8e9d46a8b12623ff96fc02c39
    erb :"Login/index"
end

# post login form data, evaluate and set session values as required
# params;
#   username
#   password
post '/login' do
    
    @username = params[:username]
    @password = params[:password]
    
    success = User.authenticate(@username, @password)
    
    if success then
        user = User.getByUsername(@username)

        session[:loggedIn] = true
        session[:username] = user.username
        session[:admin] = user.admin
        redirect '/bookmarks/all'
    end
        
    @loginError = "Username or password isn't correct."
        
    erb :"Login/index"
end

# logout the currently logged in user
get '/login/logout' do
    session[:loggedIn] = false
    session[:username] = nil
    session[:admin] = nil
    redirect '/login'
end