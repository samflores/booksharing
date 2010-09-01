require 'spec_helper'

feature "Filter books by category", %q{
  In order to borrow a book
  As a good nerd
  I want to see only the books of a given category} do
  
  background do
    [Category, Book].each(&:delete_all)
    @categories = %w(Fiction Computers Scary Suspense Comic).map { |c| Category.make!(:name => c) }
    @fiction_books = (1..3).map { Book.make!(:categories => [@categories.first]) }
    @other_books = (1..3).map { Book.make!(:categories => [@categories[rand(4)+1]]) }
  end
  
  scenario 'and there are books in it' do
    visit '/'
    click_link 'Fiction'
    @fiction_books.each do |book|
      page.should have_content(book.title)
    end
    @other_books.each do |book|
      page.should_not have_content(book.title)
    end
  end
end
