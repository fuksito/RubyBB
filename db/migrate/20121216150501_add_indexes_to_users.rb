class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :name
    add_index :users, :birthdate
    add_index :users, :gender
    add_index :users, :location
    add_index :users, :website
    add_index :users, :topics_count
    add_index :users, :messages_count
    add_index :users, :created_at
    add_index :users, :updated_at
  end
end
