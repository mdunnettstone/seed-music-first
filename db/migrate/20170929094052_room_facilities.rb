class RoomFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :room_facilities do |t|
      t.integer :room_id
      t.integer :facility_id
      t.integer :count
      t.timestamps
    end
  end
end