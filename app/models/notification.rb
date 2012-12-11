class Notification < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :message

  after_update :increment_notifications_counter
  after_save :fire_notification

  def increment_notifications_count
    self.user.increment(:notifications_count)
  end

  def fire_notification
    Net::HTTP.post_form(URI.parse("http://localhost:9292/faye"), message: {channel: "/#{self.user_id}/notifications", data: self}.to_json)
  end
end
