class Booking < ApplicationRecord
  belongs_to :user
  has_many :room_timeslots
  # belongs_to :room, through: :room_timelots

  def time_start
    room_timeslots.first.slot_start
  end

  def time_end
    room_timeslots.last.slot_end
  end

  def room
    room_timeslots.last.room
  end
end
