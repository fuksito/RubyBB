class AddLastPostAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_post_at, :datetime
  end
end
