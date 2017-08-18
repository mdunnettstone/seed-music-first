class CreateRoomComment < ActiveRecord::Migration[5.0]
  def change
    create_table :room_comments do |t|
      t.string :category
      t.text :string
      t.integer :user_id
      t.integer :room_id
    end

    add_index :room_comments, [:user_id, :room_id]
    add_index :room_comments, :room_id
  end
end
