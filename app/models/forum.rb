class Forum < ActiveRecord::Base
  has_many :topics
  attr_accessible :content, :messages_count, :name, :topics_count
end
