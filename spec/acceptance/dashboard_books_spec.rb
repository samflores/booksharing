require 'spec_helper'

feature 'Dashboard books', %q{:
  In order to keep track of borrowed books
  As a good nerd ;)
  I want to see the list of available and unavailable books
} do
  
  background do
    [Book, Author, Publisher].each(&:delete_all)
  end
  
  scenario 'no registered books' do
    visit '/'
    page.should have_content('no books! register one now!')
  end
  
  scenario 'few registered books' do
    books = (0..3).map { Book.make! }
    visit '/'
    books.each { |book| page.should have_content(book.title) }
  end
  
  scenario 'a lot of registered books' do
    books = (0..20).map { Book.make! }
    visit '/'
    books[0, 10].each { |book|  page.should have_content(book.title) }
    books[10..-1].each { |book| page.should_not have_content(book.title) }
  end
end
