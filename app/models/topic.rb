class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  paginates_per 25

  belongs_to :user
  belongs_to :forum, :counter_cache => true
  has_many :messages, :include => [:user], :dependent => :destroy
  accepts_nested_attributes_for :messages
  validates :name, :presence => true, :uniqueness => { :scope => :forum_id, :case_sensitive => false }
  validates :forum, :presence => true
  attr_accessible :name, :user_id, :forum_id, :messages_attributes

  after_update :update_counters

  private
  def update_counters
    if forum_id_was.present? and forum_id_changed?
      Forum.update_counters forum_id_was, topics_count: -1, messages_count: -messages_count
      Forum.update_counters forum_id, topics_count: 1, messages_count: messages_count
    end
  end
end
