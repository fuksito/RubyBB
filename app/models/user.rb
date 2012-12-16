# encoding: utf-8
class User < ActiveRecord::Base
  include Redirectable

  ROLES = %w[banned user moderator admin]
  has_many :roles, :dependent => :destroy
  has_many :topics
  has_many :messages
  has_many :bookmarks, :dependent => :destroy
  has_many :follows, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :notified_messages, :through => :notifications, :source => :message

  scope :with_follows, lambda { |user| select('follows.id as follow_id').joins("LEFT JOIN follows ON followable_id = users.id AND followable_type = 'User' AND follows.user_id = #{user.try(:id)}") if user }

  scope :followed_by, lambda { |user| select('follows.id as follow_id').joins("JOIN follows ON followable_id = users.id AND followable_type = 'User' AND follows.user_id = #{user.try(:id)}") if user }

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  paginates_per 25

  include Gravtastic
  gravtastic :size => 100

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {
    :x40 => "40x40^",
    :x64 => "64x64>",
    :x80 => "80x80>",
    :x100 => "100x100>",
    :x128 => "128x128>",
    :x150 => "150x150>",
    :x200 => "200x200>",
    :x256 => "256x256>"
  }, :convert_options => {
    :x40 => "-gravity center -extent 40x40"
  }

  validates :name, :presence => true, :length => { :maximum => 24 }, :uniqueness => { :case_sensitive => false }
  validates :location, :length => { :maximum => 24 }
  validates :website, :length => { :maximum => 255 }
  validates :gender, :inclusion => { :in => %w[male female other] }, :allow_blank => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_follows, lambda { |user| select('follows.id as follow_id').joins("LEFT JOIN follows ON followable_id = users.id AND followable_type = 'User' AND follows.user_id = #{user.try(:id)}") if user }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :name, :birthdate, :location, :gender, :website

  def self.find_for_database_authentication(conditions={})
    self.where("name = ? or email = ?", conditions[:email], conditions[:email]).limit(1).first
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def shortname size = 8
    name.size > size ? name.split(' ')[0][0..size-1]+"…" : name
  end

  # Do not remove strict param, see views/users/show
  # If forum_id is nil, return true if user is admin on at least one forum
  def admin? forum_id = nil, strict = false
    if forum_id
      roles.where(:forum_id => forum_id, :name => 'admin').limit(1).any?
    else
      roles.where(:name => 'admin').limit(1).any?
    end
  end

  def moderator? forum_id, strict = false
    roles.where(:forum_id => forum_id, :name => strict ? 'moderator' : ['admin', 'moderator']).limit(1).any?
  end

  def user? forum_id, strict = false
    roles.where(:forum_id => forum_id).limit(1).empty?
  end

  def banned? forum_id, strict = false
    roles.where(:forum_id => forum_id, :name => 'banned').limit(1).any?
  end

  def role forum_id = nil
    return :sysadmin if sysadmin?
    return :user unless forum_id
    roles.where(:forum_id => forum_id).limit(1).first.try(:name) || :user
  end
end
