class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_comment = RoomComment.new
  end

  def new
    @room_timeslots = build_room_times(00:00, 23:45)
  end

  private

  def build_room_times(start_time, end_time)
  [start_time].tap { |array| array << array.last + 15.minutes while array.last < end_time }
  end
end
