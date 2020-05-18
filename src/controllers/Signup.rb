# Signup.rb
# Alex Parr
# 18/05/2020

require 'sinatra'
require 'sinatra/reloader'



get '/signup' do
    erb :"Signup/index"
end

post '/signup' do
    
    
    @signupError = "Form Posted"
    @signupSuccess = "Form Posted"
    erb :"Signup/index"
        
end