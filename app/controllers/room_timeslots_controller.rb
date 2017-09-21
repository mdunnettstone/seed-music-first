class RoomTimeslotsController < ApplicationController
  def new
    @room_timeslot = RoomTimeslot.new
  end
end
