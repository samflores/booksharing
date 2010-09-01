require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV['RACK_ENV'] || 'development')

require 'sinatra'
require './lib/setup'
require './models/author'
require './models/publisher'
require './models/category'
require './models/book'

get '/' do
  q = params[:q] rescue nil
  @books = q ? Book.global_search(q) : Book.recent
  @books = @books.categorized(params[:c]) if params[:c]
  erb :dashboard
end