class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :default => 'retro', :size => 128

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :small => "128x128>" }

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

end
