require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV['RACK_ENV'] || 'development')

require 'sinatra'
require './lib/setup'
require './models/author'
require './models/publisher'
require './models/book'

get '/' do
  q = params[:search][:q] rescue nil
  @books = q ? Book.global_search(q) : Book.recent
  erb :dashboard
end