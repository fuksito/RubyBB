class AddUpdaterIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :updater_id, :integer, :references => :users
    add_index :topics, :updater_id
  end
end
