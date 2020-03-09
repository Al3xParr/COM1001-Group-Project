# Index.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'

get '/' do
    erb :"Index/index"
end