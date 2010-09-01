class Book < ActiveRecord::Base
  belongs_to :publisher
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  
  validates_presence_of :isbn, :title
  validates_uniqueness_of :isbn
  validates_length_of :authors, :minimum => 1, :message => "can't be empty"
  
  scope :recent, :limit => 10
  scope :global_search, lambda { |q| where(["isbn = ? or LOWER(title) LIKE ?", q, "%#{q.downcase}%"]) }
  scope :categorized, lambda { |c| includes(:categories).where(:categories => { :name => c } ) }
end