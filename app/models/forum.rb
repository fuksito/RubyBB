class Forum < ActiveRecord::Base
  default_scope order(:position)

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  has_many :topics, :dependent => :destroy
  has_many :roles
  has_many :follows, :as => :followable, :dependent => :destroy
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  scope :with_follows, lambda { |user| select('follows.id as follow_id').joins("LEFT JOIN follows ON followable_id = forums.id AND followable_type = 'Forum' AND follows.user_id = #{user.try(:id)}") if user }

  attr_accessible :content, :name
end
