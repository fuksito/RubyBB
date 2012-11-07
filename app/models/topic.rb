class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :messages
  attr_accessible :messages_count, :name
end
