class AddUpdaterIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :updater_id, :integer, :references => :users
    add_index :messages, :updater_id
  end
end
