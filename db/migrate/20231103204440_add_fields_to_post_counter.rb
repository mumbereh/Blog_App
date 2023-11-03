class AddFieldsToPostCounter < ActiveRecord::Migration[7.1]
  def change
    add_column :post_counters, :comments_count, :integer, default: 0
    add_column :post_counters, :likes_count, :integer, default: 0
  end
end

