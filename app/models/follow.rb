class Follow < ActiveRecord::Base
  belongs_to :followable, :polymorphic => true
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:followable_id, :followable_type]
  attr_accessible :followable_id, :followable_type
end
