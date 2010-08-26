require 'spec_helper'

describe "setup" do
  background {
    ENV['RACK_ENV'] = 'test'
    config_file = <<-FILE
development:
  adapter: sqlite3
  database: ./db/books_devel.sqlite3
test:
  adapter: sqlite3
  database: ./db/books_test.sqlite3
production:
  adapter: sqlite3
  database: ./db/books_prod.sqlite3
FILE
    schema_file = <<-FILE
Book:
  title:
    type: string
    limit: 50
FILE
  File.stub!(:read).with('config/database.yml').and_return(config_file)
  File.stub!(:read).with('db/schema.yml').and_return(schema_file)
  }
  
  it 'should connect to database' do
    FileUtils.rm './db/books_test.sqlite3', :force => true
    lambda { Setup.connect_to_database! }.should_not raise_error
  end
  
  it 'should create the tables' do
    Setup.connect_to_database!
    Setup.create_tables!
    Setup.database.tables.should include('books')
  end
end