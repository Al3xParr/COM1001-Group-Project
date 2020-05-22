#Author: Aryan
require "rake/testtask"
# replace the below with the path to your app
require_relative 'app'

 
desc "run acceptance test"
task :feature do
    sh "cucumber"
end

desc "Run the Sinatra app locally"
task :run do
Sinatra::Application.run!
end