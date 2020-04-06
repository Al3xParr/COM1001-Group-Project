require_relative 'models/User'
require_relative 'models/Bookmark'

puts Bookmark.newBookmark("Test", "Test description", "https://google.co.uk/", 0, 1)