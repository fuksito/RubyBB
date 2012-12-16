class AddPositionToForums < ActiveRecord::Migration
  def change
    add_column :forums, :position, :integer
    add_index :forums, :position
  end
end
