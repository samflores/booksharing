require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV['RACK_ENV'] || 'development')

require 'sinatra'
require './models/author'
require './models/publisher'
require './models/book'
require './lib/setup'

get '/' do
  @books = Book.all(:limit => 10)
  erb :dashboard
end