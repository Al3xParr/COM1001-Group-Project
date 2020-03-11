# Login.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative 'models/User'

# return the login page
get '/login' do
    
    erb: "Login/index.erb"
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
        redirect '/bookmarks'
    end
        
    @loginError = "Username or password isn't correct."
    redirect '/login'
end

# logout the currently logged in user
post '/login/logout' do
    
    session[:loggedIn] = false
    redirect '/login'
end