class Book < ActiveRecord::Base
  belongs_to :publisher
  has_and_belongs_to_many :authors
  
  validates_presence_of :isbn, :title
  validates_uniqueness_of :isbn
  validates_length_of :authors, :minimum => 1, :message => "can't be empty"
end