class AddPhotoToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :photo, :string
  end
end
