require_relative 'models/User'
require_relative 'models/Bookmark'

puts Bookmark.newBookmark("Staff payroll 2020", "This is the staff payrol for the year blah blah blah", "https://some.internal.server/payroll/2020.xlsx/", 0, 1)