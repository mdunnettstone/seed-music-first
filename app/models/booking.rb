class Booking < ApplicationRecord
  belongs_to :user
  has_many :room_timeslots

end
