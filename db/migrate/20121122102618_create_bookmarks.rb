class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user
      t.references :topic
      t.references :message

      t.timestamps
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :topic_id
    add_index :bookmarks, :message_id
  end
end
