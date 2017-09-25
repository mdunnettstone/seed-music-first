class RoomTimeslotsController < ApplicationController
  def new
    @room_timeslot = RoomTimeslot.new
  end

  def index
    room_timeslots = RoomTimeslot.all
    render json: room_timeslots
  end

  def update
    room_timeslot = RoomTimeslot.find_by_id(params[:id])
    room_timeslot.update_attributes(timeslot_params)
  end

  def show
    room_timeslot = RoomTimeslot.find_by_id(params[:id])
    render json: room_timeslot
  end

  private

  def timeslot_params
    params.require(:room_timeslot).permit(:booking_id)
  end
end
