# Signup.rb
# Alex Parr
# 18/05/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/User'



get '/signup' do
    erb :"Signup/index"
end

post '/signup' do
    
    @password = params[:password]
    @repassword = params[:repassword]
    @username = params[:username]
    
    if @password != @repassword then
        @signupError = "Passwords don't match"
        
    elsif User.getByUsername(@username) != nil then
        @signupError = "Username already exists"
        
    else
        
        @signupSuccess = "Passwords the same and username not already in use"
    end
    
    erb :"Signup/index"
        
end