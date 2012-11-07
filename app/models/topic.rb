class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  has_many :messages
  attr_accessible :name, :user_id, :forum_id
end
