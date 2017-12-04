class RoomFacility < ApplicationRecord
  belongs_to :room
  belongs_to :facility
  belongs_to :account

end
