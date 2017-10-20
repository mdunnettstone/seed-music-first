class AddTimestampsToRoomComment < ActiveRecord::Migration[5.0]
  def change
    add_column :room_comments, :created_at, :datetime, null: false
    add_column :room_comments, :updated_at, :datetime, null: false
  end
end
