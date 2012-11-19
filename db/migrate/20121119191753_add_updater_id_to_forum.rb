class AddUpdaterIdToForum < ActiveRecord::Migration
  def change
    add_column :forums, :updater_id, :integer, :references => :users
    add_index :forums, :updater_id
  end
end
