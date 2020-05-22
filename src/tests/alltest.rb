#alltest.rb
#Author:Aryan
#Date:22/05/20

#to run all minitest from one command 
Dir[File.dirname(File.absolute_path(__FILE__)) + '/*_test.rb'].each {|file| require file }