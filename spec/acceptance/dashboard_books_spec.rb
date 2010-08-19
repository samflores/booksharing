require 'spec_helper'

feature 'Dashboard books', %q{
  In order to keep track of borrowed books
  As a good nerd
  I want to see the list of available and unavailable books} do
  
  scenario 'no registered books' do
    visit '/'
    page.should have_content('no books! register one now!')
  end
end

