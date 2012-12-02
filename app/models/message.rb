class Message < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  acts_as_paranoid

  PER_PAGE = 20
  paginates_per PER_PAGE

  has_many :small_messages, :dependent => :destroy
  has_many :follows, :as => :followable, :dependent => :destroy
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :forum, :counter_cache => true, :touch => true
  validates :content, :presence => true
  attr_accessible :content, :topic_id

  scope :with_follows, lambda { |user| select('follows.id as follow_id').joins("LEFT JOIN follows ON followable_id = messages.id AND followable_type = 'Message' AND follows.user_id = #{user.try(:id)}") if user }

  mapping do
    indexes :id, :index => :not_analyzed
    indexes :content, :analyzer => 'snowball'
    indexes :topic, :as => 'topic.name', :analyzer => 'snowball'
    indexes :user, :as => 'user.name', :analyzer => 'snowball'
    indexes :at, :as => 'created_at', :type => 'date'
  end

  before_save :render_content
  after_save :fire_notifications

  def render_content
    @user_ids = Array.new
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new link_attributes: {rel: 'nofollow', target: '_blank'}, filter_html: false
    extensions = {space_after_headers: true, no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, strikethrough: true, superscript: true}
    hashtagged = CGI::escapeHTML(self.content).gsub(/(^|\s)@([[:alnum:]_-]+)/u) { |tag|
      if user = User.where(name: $2).first
        @user_ids << user.id
        "#{$1}#{ActionController::Base.helpers.link_to("@#{$2}", Rails.application.routes.url_helpers.user_path(user))}"
      else
        tag
      end
    }.gsub(/(^|\s)#([[:alnum:]_-]+)/u) { |tag|
      "#{$1}#{ActionController::Base.helpers.link_to("##{$2}", Rails.application.routes.url_helpers.messages_path(q: $2))}"
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_content = redcarpet.render(hashtagged)
  end

  def fire_notifications
    @user_ids.each do |uid|
      if uid != self.user_id
        Notification.find_or_create_by_user_id_and_message_id(uid, self.id).touch
      end
    end
    Follow.not_by(self.user_id).where(:followable_id => self.user_id, :followable_type => 'User').each do |f|
      Notification.find_or_create_by_user_id_and_message_id(f.user_id, self.id).touch
    end
    Follow.not_by(self.user_id).where(:followable_id => self.topic_id, :followable_type => 'Topic').each do |f|
      Notification.find_or_create_by_user_id_and_message_id(f.user_id, self.id).touch
    end
    if self.topic.messages_count == 1
      Follow.not_by(self.user_id).where(:followable_id => self.forum_id, :followable_type => 'Forum').each do |f|
        Notification.find_or_create_by_user_id_and_message_id(f.user_id, self.id).touch
      end
    end
  end

end
