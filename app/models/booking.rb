class Booking < ApplicationRecord
  has_many :user_bookings
  has_many :users, :through => :user_bookings
  has_many :room_timeslots
  # belongs_to :room, through: :room_timelots

end
