class AddParentIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :parent_id, :integer, :references => :forums
    add_index :forums, :parent_id
  end
end
