class Redirection < ActiveRecord::Base
  belongs_to :redirectable, :polymorphic => true
  validates_uniqueness_of :slug, :scope => :redirectable_type

  attr_accessible :redirectable_id, :redirectable_type, :slug
end
