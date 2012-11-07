class Forum < ActiveRecord::Base
  has_many :topics
  attr_accessible :content, :name
end
