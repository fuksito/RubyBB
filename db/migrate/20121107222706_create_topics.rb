class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, :null => false
      t.references :user
      t.references :forum
      t.integer :messages_count, :default => 0, :null => false

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :forum_id
  end
end
