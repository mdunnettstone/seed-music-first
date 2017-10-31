class AddCreatorToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :creator_user_id, :integer
    remove_column :bookings, :user_id
  end
end
