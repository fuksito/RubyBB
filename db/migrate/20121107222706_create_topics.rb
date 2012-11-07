class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.references :user
      t.references :forum
      t.integer :messages_count

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :forum_id
  end
end
