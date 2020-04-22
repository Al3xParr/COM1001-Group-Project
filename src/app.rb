# app.rb
# date      27/02/20
# author    Luke Suckling

require 'sinatra'
require 'sqlite3'

require_relative 'controllers/Admin'
require_relative 'controllers/Bookmarks'
require_relative 'controllers/Index'
require_relative 'controllers/Login'
require_relative 'controllers/Errors'
require_relative 'controllers/Comments'
require_relative 'controllers/Tags'

set :bind, '0.0.0.0'
enable :sessions
set :views, 'views'
