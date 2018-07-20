require 'bundler'
Bundler.require
require_all 'app'

ActiveRecord::Base.establish_connection({
  :adapter => "mysql2",
  :database  => "people",
  :host => "localhost",
  :username => "root",
  :password => "admin"})
  