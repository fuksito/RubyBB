class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  has_many :messages, :include => [:user]
  validates :name, :presence => true, :uniqueness => { :scope => :forum_id, :case_sensitive => false }
  validates :forum, :presence => true
  attr_accessible :name, :user_id, :forum_id
end
