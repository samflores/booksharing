require 'spec_helper'

describe Book do
  before(:each) { [Book, Author, Publisher].each(&:delete_all) }
  subject do
    Book.new  :isbn => 9876543218,
              :title => 'Agile Web Development With Rails',
              :authors => [
                Author.new(:name => 'David Heinemeier Hansson'),
                Author.new(:name => 'Dave Thomas')
              ],
              :publisher => Publisher.new(:name => 'The Pragmatic Programmers')
  end
  
  it 'should not be valid without an isbn' do
    subject.isbn = nil
    subject.should_not be_valid
    subject.errors[:isbn].should include("can't be blank")
  end
  
  it 'should not be valid with an already used isbn' do
    subject.should be_valid
    subject.save.should be_true
    book = Book.new :isbn => 9876543218, 
                    :title => 'Other title', 
                    :authors => [subject.authors.last],
                    :publisher => subject.publisher
    book.should_not be_valid
  end
  
  it 'should not be valid without a title' do
    subject.title = nil
    subject.should_not be_valid
    subject.errors[:title].should include("can't be blank")
  end
  
  it 'should not be valid without an author' do
    subject.authors = []
    subject.should_not be_valid
    subject.errors[:authors].should include("can't be empty")
  end
end