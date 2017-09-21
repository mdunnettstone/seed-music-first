class RoomTimeslot < ApplicationRecord
  belongs_to :room
  has_one :booking

end
