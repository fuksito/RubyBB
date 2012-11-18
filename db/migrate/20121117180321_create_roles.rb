class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :user, :forum
      t.timestamps
    end
    add_index :roles, :user_id
    add_index :roles, :forum_id
  end
end
