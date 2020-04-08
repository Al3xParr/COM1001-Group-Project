# Admin.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'

# fetch the admin 'homepage'
# /admin
get '/admin' do
    
    if session[:admin] then
        "hello mr admin"
    else
        status 404
    end
end