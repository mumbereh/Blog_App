class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :commentsCounter
      t.string :LikesCounter
      t.references :author, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
