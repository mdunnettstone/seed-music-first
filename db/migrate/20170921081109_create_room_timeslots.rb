class CreateRoomTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table :room_timeslots do |t|
      t.datetime :slot_start
      t.datetime :slot_end
      t.integer :room_id
      t.integer :booking_id
      t.timestamps
    end
  end
end
