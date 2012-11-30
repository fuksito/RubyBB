class SmallMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :topic
  belongs_to :forum
  attr_accessible :content, :message_id, :forum_id
  validates :content, :presence => true

  after_save :fire_notifications

  def fire_notifications
    Notification.find_or_create_by_user_id_and_message_id(self.message.user_id, self.message_id).touch
    Follow.not_by(self.user_id).where(:followable_id => self.message_id, :followable_type => 'Message').each do |f|
      Notification.find_or_create_by_user_id_and_message_id(f.user_id, self.message_id).touch
    end
  end
end
