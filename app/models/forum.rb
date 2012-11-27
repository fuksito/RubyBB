class Forum < ActiveRecord::Base
  default_scope order(:position)

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  has_many :topics, :dependent => :destroy
  has_many :roles
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  attr_accessible :content, :name
end
