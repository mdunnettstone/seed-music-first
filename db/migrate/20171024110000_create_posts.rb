class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :category
      t.text :message
      t.boolean :live
      t.timestamps
    end
  end
end
