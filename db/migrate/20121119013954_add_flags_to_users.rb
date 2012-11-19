class AddFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :human, :boolean, :default => 0
    add_column :users, :sysadmin, :boolean, :default => 0
  end
end
