class Forum < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  has_many :topics, :dependent => :destroy
  has_many :roles
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  attr_accessible :content, :name
end
