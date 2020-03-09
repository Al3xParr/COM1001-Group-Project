require_relative '../models/User'

#puts User.newUser("luke", "password", 1)

puts User.authenticate("luke", "password")
