class Notification < ActiveRecord::Base
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  belongs_to :user, :counter_cache => true
  belongs_to :message

  after_update :increment_notifications_counter
  after_save :publish

  def increment_notifications_count
    self.user.increment(:notifications_count)
  end

  def publish
    data = {
      # avatar should use shared/avatar partial
      avatar: self.message.user.avatar.exists? ? self.message.user.avatar.url(:icon) : self.message.user.gravatar_url(d: 'retro'),
      title: truncate(self.message.topic.name, length: 20, separator: ' ', omission: '...'),
      content: truncate(self.message.content, length: 24, separator: ' ', omission: '...'),
      link: topic_path(self.message.topic) + '?newest'
    }
    Net::HTTP.post_form(URI.parse("http://localhost:9292/faye"), message: {channel: "/#{self.user_id}/notifications", data: data}.to_json)
  end
end
