class Room < ApplicationRecord
  has_many :room_comments
  has_many :room_timeslots
  has_many :bookings, through: :room_timeslots
end
