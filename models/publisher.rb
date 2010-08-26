class Publisher < ActiveRecord::Base
  has_many :books
  validates_presence_of :name
  # validates_length_of :books, :minimum => 1, :message => "can't be empty"
end