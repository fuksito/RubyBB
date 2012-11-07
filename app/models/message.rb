class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :forum
  attr_accessible :content
end
