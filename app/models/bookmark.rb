class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :message
  validates_uniqueness_of :user_id, :scope => :topic_id
end
