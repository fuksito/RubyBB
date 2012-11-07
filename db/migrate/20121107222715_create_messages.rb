class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user
      t.references :topic
      t.references :forum

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :topic_id
    add_index :messages, :forum_id
  end
end
