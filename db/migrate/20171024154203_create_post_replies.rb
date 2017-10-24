class CreatePostReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :post_replies do |t|
      t.text :message
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end
  end
end
