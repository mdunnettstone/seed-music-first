class Room < ApplicationRecord
  has_many :room_comments
  has_many :bookings
end
