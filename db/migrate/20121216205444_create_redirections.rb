class CreateRedirections < ActiveRecord::Migration
  def change
    create_table :redirections do |t|
      t.string :redirectable_type
      t.integer :redirectable_id
      t.string :slug

      t.timestamps
    end
    add_index :redirections, :redirectable_type
    add_index :redirections, :slug
  end
end
