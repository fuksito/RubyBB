class AddViewsCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :views_count, :integer, :default => 0, :null => false
    add_column :topics, :viewer_id, :integer, :references => :users
    add_index :topics, :viewer_id
  end
end
