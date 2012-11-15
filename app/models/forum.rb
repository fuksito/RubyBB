class Forum < ActiveRecord::Base
  acts_as_paranoid
  has_many :topics, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  attr_accessible :content, :name
end
