class Message < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  acts_as_paranoid
  paginates_per 20

  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :forum, :counter_cache => true, :touch => true
  validates :content, :presence => true
  attr_accessible :content, :user_id, :topic_id, :forum_id

  mapping do
    indexes :id, :index => :not_analyzed
    indexes :content, :analyzer => 'snowball', :boost => 100
    indexes :topic, :as => 'topic.name', :analyzer => 'snowball', :boost => 10
    indexes :user, :as => 'user.name', :analyzer => 'snowball'
    indexes :at, :as => 'created_at', :type => 'date'
  end

  before_save :render_content

  private
  def render_content
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new link_attributes: {rel: 'nofollow', target: '_blank'}, filter_html: true
    extensions = {no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, strikethrough: true, superscript: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_content = redcarpet.render self.content
  end

end
