class AddPinnedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :pinned, :boolean, :default => false
  end
end
