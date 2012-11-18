class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  attr_accessible :name, :user_id, :forum_id
end
