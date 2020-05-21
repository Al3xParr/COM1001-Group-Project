require_relative 'models/User'
require_relative 'models/Bookmark'
require_relative 'models/SignupRequest'

#puts Bookmark.newBookmark("Staff payroll 2020", "This is the staff payrol for the year blah blah blah", "https://some.internal.server/payroll/2020.xlsx/", 0, 1)
puts User.newUser("admin", "admin", 1, 0)
puts User.newUser("user", "user", 0, 0)
puts User.newUser("role1", "role1", 0, 0)
puts User.newUser("role2", "role2", 0, 0)
puts User.newUser("role3", "role3", 0, 0)
puts User.newUser("role4", "role4", 0, 0)
