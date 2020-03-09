# app.rb
# date      27/02/20
# author    Luke Suckling

require 'sinatra'

require_relative 'controllers/Admin'
require_relative 'controllers/Bookmarks'
require_relative 'controllers/Index'
require_relative 'controllers/Login'

set :bind, '0.0.0.0'

