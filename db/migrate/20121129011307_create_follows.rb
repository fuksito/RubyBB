class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :followable, polymorphic: true
      t.references :user

      t.timestamps
    end
    add_index :follows, :followable_id
    add_index :follows, :followable_type
    add_index :follows, :user_id
  end
end
