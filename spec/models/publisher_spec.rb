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
    subject.errors[:name].should include("can't be blank")
  end
end