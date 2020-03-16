# Login.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/User'

# return the login page
get '/login' do
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
        session[:loggedIn] = true
        session[:username] = @username
        redirect '/bookmarks/all'
    end
        
    @loginError = "Username or password isn't correct."
        
    erb :"Login/index"
end

# logout the currently logged in user
get '/login/logout' do
    session[:loggedIn] = false
    redirect '/login'
end