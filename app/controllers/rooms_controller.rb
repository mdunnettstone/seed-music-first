class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.order(:id)
    @user_bookings = current_user.bookings.where("(start_time > ?)", Time.now)
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_comment = RoomComment.new
    @bookings = current_user.bookings.where("(room_id = ? AND start_time > ?)", @room.id, Time.now).sort_by{|booking| booking.start_time}
  end

  private

  helper_method :current_room
  def current_room
    @current_room ||= Room.find_by_id(params[:id])
  end
end
