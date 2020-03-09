require 'sinatra'
require 'sinatra/reloader'

get '/' do
    erb :"Index/index"
end