class AddIndexForDeletedAt < ActiveRecord::Migration
  def change
    add_index :forums, :deleted_at
    add_index :topics, :deleted_at
    add_index :messages, :deleted_at
    add_index :users, :deleted_at
  end
end
