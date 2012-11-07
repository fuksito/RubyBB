class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :content
      t.integer :topics_count
      t.integer :messages_count

      t.timestamps
    end
  end
end
