class AddRenderedContentToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :rendered_content, :text
  end
end
