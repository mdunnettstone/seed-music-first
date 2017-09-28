class CreateUserBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_bookings do |t|
      t.integer :booking_id
      t.integer :user_id
      t.timestamps
    end
  end
end
