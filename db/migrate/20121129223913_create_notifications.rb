class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :message

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, :message_id
  end
end
