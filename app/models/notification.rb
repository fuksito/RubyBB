class Notification < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :message
  attr_accessible :user_id, :message_id
end
