class AddIndexesToTopics < ActiveRecord::Migration
  def change
    add_index :topics, :pinned
    add_index :topics, :updated_at
  end
end
