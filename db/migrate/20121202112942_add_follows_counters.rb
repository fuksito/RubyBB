class AddFollowsCounters < ActiveRecord::Migration
  def change
    add_column :users, :follows_count, :integer, :default => 0, :null => false
    add_column :forums, :follows_count, :integer, :default => 0, :null => false
    add_column :topics, :follows_count, :integer, :default => 0, :null => false
    add_column :messages, :follows_count, :integer, :default => 0, :null => false
  end
end
