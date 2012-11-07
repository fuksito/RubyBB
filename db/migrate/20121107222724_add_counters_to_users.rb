class AddCountersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :messages_count, :integer
    add_column :users, :topics_count, :integer
  end
end
