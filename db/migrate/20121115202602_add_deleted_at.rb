class AddDeletedAt < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_column :forums, :deleted_at, :datetime
    add_column :topics, :deleted_at, :datetime
    add_column :messages, :deleted_at, :datetime
  end
end
