# Bookmarks.rb
# Author: Luke Suckling
# Date: 09/03/2020

require 'sinatra'
require 'sinatra/reloader'

# show all avaliable bookmarks
# /bookmarks/all
get '/bookmarks/all' do
    
end

# search bookmarks using parameters
# return the form to allow user to search
get '/bookmarks/search' do
    erb :"Bookmarks/bookmark"
end

#post search form data and perform search using values
post '/bookmarks/search' do
    
end

# return edit page for defined bookmark paramter
# /bookmarks/edit?id={bookmark id}
get '/bookmarks/edit' do

end

# update the defined bookmark with the parsed post data
# /bookmarks/edit
post '/bookmarks/edit' do

end

# view the bookmarks own page
# /bookmarks/view?id={bookmark id}
get '/bookmarks/view' do

end

# create a comment on the bookmark
# returns:
#   the individual view page of the bookmark i.e.
#   /bookmarks/view?id={bookmark id}
post '/bookmarks/comment' do

end