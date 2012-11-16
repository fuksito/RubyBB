class AddSlug < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :forums, :slug, :string
    add_column :topics, :slug, :string
    add_index :users, :slug, :unique => true
    add_index :forums, :slug, :unique => true
    add_index :topics, :slug, :unique => true
  end
end
