# Errors.rb
# Author: Luke Suckling
# Date: 08/04/2020

require 'sinatra'
require 'sinatra/reloader'

not_found do
    @errorMessage = "Looks like the resource you asked for can't be found."

    erb :"Errors/error"
end
error do
    @errorMessage = "An error has occured."

    erb :"Errors/error"
end