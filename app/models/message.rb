class Message < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  acts_as_paranoid

  PER_PAGE = 20
  paginates_per PER_PAGE

  has_many :small_messages, :dependent => :destroy
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :forum, :counter_cache => true, :touch => true
  validates :content, :presence => true
  attr_accessible :content, :user_id, :topic_id, :forum_id

  mapping do
    indexes :id, :index => :not_analyzed
    indexes :content, :analyzer => 'snowball'
    indexes :topic, :as => 'topic.name', :analyzer => 'snowball'
    indexes :user, :as => 'user.name', :analyzer => 'snowball'
    indexes :at, :as => 'created_at', :type => 'date'
  end

  before_save :render_content

  private
  def render_content
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new link_attributes: {rel: 'nofollow', target: '_blank'}, filter_html: false
    extensions = {space_after_headers: true, no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, strikethrough: true, superscript: true}
    hashtagged = CGI::escapeHTML(self.content).gsub(/(^|\s)@([[:alnum:]_-]+)/u) { |tag|
      begin
        "#{$1}#{ActionController::Base.helpers.link_to("@#{$2}", Rails.application.routes.url_helpers.user_path(User.where(name: $2).first))}"
      rescue
        tag
      end
    }.gsub(/(^|\s)#([[:alnum:]_-]+)/u) { |tag|
      "#{$1}#{ActionController::Base.helpers.link_to("##{$2}", Rails.application.routes.url_helpers.messages_path(q: $2))}"
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_content = redcarpet.render(hashtagged)
  end

end
