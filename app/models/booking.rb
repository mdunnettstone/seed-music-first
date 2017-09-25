class Booking < ApplicationRecord
  belongs_to :user
  has_many :room_timeslots
  # belongs_to :room, through: :room_timelots

end
