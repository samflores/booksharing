require 'spec_helper'

feature "Search books by ISBN", %q{:
  In order to borrow a book
  As good nerd
  I want to search for interesting books by ISBN} do
    
  background do
    [Book, Author, Publisher].each(&:delete_all)
    Book.make!(:title => 'Some amazing book', :isbn => '8792948583')
    Book.make!(:title => 'Some boring book', :isbn => '8792983838')
  end
  
  scenario 'the book is registered' do
    visit '/'
    fill_in 'Search', :with => '8792948583'
    click_button 'Go'
    page.should have_content('Some amazing book')
    page.should_not have_content('Some boring book')
  end
  
  scenario 'the book is not registered' do
    visit '/'
    fill_in 'Search', :with => '8723923438'
    click_button 'Go'
    page.should_not have_content('Some amazing book')
    page.should_not have_content('Some boring book')
  end
end