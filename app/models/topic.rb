class Topic < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 25

  belongs_to :user
  belongs_to :forum, :counter_cache => true
  has_many :messages, :include => [:user], :dependent => :destroy
  accepts_nested_attributes_for :messages
  validates :name, :presence => true, :uniqueness => { :scope => :forum_id, :case_sensitive => false }
  validates :forum, :presence => true
  attr_accessible :name, :user_id, :forum_id, :messages_attributes
end
