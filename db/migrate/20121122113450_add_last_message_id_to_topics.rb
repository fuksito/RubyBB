class AddLastMessageIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_message_id, :integer, :references => :messages
    add_index :topics, :last_message_id
  end
end
