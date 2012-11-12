class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name, :null => false
      t.text :content
      t.integer :topics_count, :default => 0, :null => false
      t.integer :messages_count, :default => 0, :null => false

      t.timestamps
    end
  end
end
