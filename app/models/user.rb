class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid
  paginates_per 25

  include Gravtastic
  gravtastic :default => 'retro', :size => 100

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {
    :mini => "80x80>",
    :small => "100x100>",
    :medium => "128x128>",
    :large => "150x150>",
    :xlarge => "200x200>",
    :xxlarge => "256x256>"
  }

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :gender, :inclusion => { :in => %w[male female other] }, :allow_blank => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :name, :birthdate, :location, :gender, :website

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

end
