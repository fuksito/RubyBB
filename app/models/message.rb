class Message < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :forum, :counter_cache => true, :touch => true
  attr_accessible :content, :user_id, :topic_id, :forum_id
end
