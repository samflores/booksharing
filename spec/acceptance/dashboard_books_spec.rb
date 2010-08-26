require 'spec_helper'

feature 'Dashboard books', %q{:
  In order to keep track of borrowed books
  As a good nerd ;)
  I want to see the list of available and unavailable books
} do
  
  background do
    [Book, Author, Publisher].each(&:delete_all)
    @author = Author.create(:name => 'John Doe')
    @publisher = Publisher.create(:name => 'PragProg')
    @titles = [ 'HTML5 & CSS3', 'Ubuntu Kung Fu', 'Learn to Program', 'Code in the Cloud',
                'The Agile Samurai', 'Programming Erlang', 'The Pragmatic Programmer',
                'Beginning Mac Programming', 'Pomodoro Technique Illustrated',
                'Agile Web Development With Rails', 'Pragmatic Unit Testing in C# with NUnit',
                'Core Animation for Mac OS X and the iPhone']
  end
  
  scenario 'no registered books' do
    visit '/'
    page.should have_content('no books! register one now!')
  end
  
  scenario 'few registered books' do
    books = create_books(3)
    visit '/'
    books.each { |book| page.should have_content(book.title) }
  end
  
  scenario 'a lot of registered books' do
    books = create_books(:all)
    visit '/'
    books[0, 10].each { |book|  page.should have_content(book.title) }
    books[10..-1].each { |book| page.should_not have_content(book.title) }
  end
  
  def create_books(qty)
    qty = @titles.length if qty == :all
    @titles[0, qty].map do |title|
      Book.create :title => title, :isbn => rand(9999999999), :authors => [@author], :publisher => @publisher
    end
  end
end
