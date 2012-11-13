class Forum < ActiveRecord::Base
  has_many :topics
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  attr_accessible :content, :name
end
