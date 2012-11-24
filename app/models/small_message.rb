class SmallMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :topic
  belongs_to :forum
  attr_accessible :content, :message_id, :forum_id
end
