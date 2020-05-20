# Signup.rb
# Alex Parr
# 18/05/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/User'
require_relative '../models/SignupRequest'



get '/signup' do
    erb :"Signup/index"
end

post '/signup' do
    
    @password = params[:password]
    @repassword = params[:repassword]
    @username = params[:username]
    @reason = params[:reason]
    
    if @password != @repassword then
        @signupError = "Passwords don't match"
        
    elsif User.getByUsername(@username) != nil then
        @signupError = "Username already exists"
        
    else
        if User.newUser(@username, @password, 0, 1) 
            
            
            newAccount = User.getByUsername(@username)
            if SignupRequest.newRequest(newAccount.userId, @reason)
                @signupSuccess = "Account created and sent for approval"
            else
                @signupError = "Sign up request not logged"
            end
        else
            @signupError = "Account unable to be created"
        end
    end
    
    erb :"Signup/index"
        
end