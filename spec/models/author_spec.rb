require 'spec_helper'

describe Author do
  subject { Author.new(:name => 'Samuel Flores') }
  
  it 'should not be valid without a name' do
    subject.name = nil
    subject.should_not be_valid
    subject.errors[:name].should include("can't be blank")
  end
end