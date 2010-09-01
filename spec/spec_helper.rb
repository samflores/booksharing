ENV['RACK_ENV'] = 'test'

require File.expand_path('../booksharing', File.dirname(__FILE__))
require File.expand_path('support/blueprints', File.dirname(__FILE__))

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

Capybara.app = Sinatra::Application

Spec::Runner.configure do |config| 
  config.include(Capybara, :type => :integration) 
end