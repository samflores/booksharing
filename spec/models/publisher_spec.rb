require 'spec_helper'

describe Publisher do
  subject do
    Publisher.new :name => 'Novatec',
                  :books => [ 
                    Book.new(:title => 'Some Title', 
                             :authors => [Author.new(:name => 'Zezinho')])]
  end
  
  it 'should not be valid without a name' do
    subject.name = nil
    subject.should_not be_valid
    subject.errors.on(:name).should include("can't be blank")
  end
  
  xit 'should not be valid without a book' do
    subject.books = []
    subject.should_not be_valid
    subject.errors.on(:books).should include("can't be empty")
  end
end