class AddPinnedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :pinned, :boolean
  end
end
