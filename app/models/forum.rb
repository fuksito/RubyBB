class Forum < ActiveRecord::Base
  default_scope order(:position, :parent_id, :name)

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  has_many :children, :class_name => 'Forum', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Forum', :foreign_key => 'parent_id'
  has_many :topics, :dependent => :destroy
  has_many :roles
  has_many :follows, :as => :followable, :dependent => :destroy
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  scope :with_follows, lambda { |user| select('follows.id as follow_id').joins("LEFT JOIN follows ON followable_id = forums.id AND followable_type = 'Forum' AND follows.user_id = #{user.try(:id)}") if user }

  attr_accessible :content, :name, :parent_id

  def fix_counters
    topics = Topic.where(:forum_id => children.map(&:id) << id).count
    messages = Message.where(:forum_id => children.map(&:id) << id).count
    Forum.update_counters id, topics_count: topics - topics_count, messages_count: messages - messages_count
  end
end
