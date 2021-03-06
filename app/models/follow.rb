class Follow < ActiveRecord::Base
  belongs_to :followable, :polymorphic => true, :counter_cache => true
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:followable_id, :followable_type]
  attr_accessible :followable_id, :followable_type
  scope :not_by, lambda{ |uid| where('user_id != ?', uid) }
end
