class Room < ApplicationRecord
  has_many :room_timeslots
  has_many :bookings, through: :room_timeslots
  has_many :room_comments
  has_many :room_facilities
  has_many :facilities, through: :room_facilities
  accepts_nested_attributes_for :room_facilities
end
