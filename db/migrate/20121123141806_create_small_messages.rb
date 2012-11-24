class CreateSmallMessages < ActiveRecord::Migration
  def change
    create_table :small_messages do |t|
      t.references :message
      t.references :user
      t.references :topic
      t.references :forum
      t.string :content

      t.timestamps
    end
    add_index :small_messages, :message_id
    add_index :small_messages, :user_id
    add_index :small_messages, :topic_id
    add_index :small_messages, :forum_id
  end
end
