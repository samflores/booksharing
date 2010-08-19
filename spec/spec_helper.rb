ENV['RACK_ENV'] = 'test'

require File.expand_path('../booksharing', File.dirname(__FILE__))

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
