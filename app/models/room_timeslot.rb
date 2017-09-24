class RoomTimeslot < ApplicationRecord
  belongs_to :room
  belongs_to :booking, required: false

end
