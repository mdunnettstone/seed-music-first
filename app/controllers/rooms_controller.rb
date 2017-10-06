class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
    redirect_to room_path(@room)
  end

  def index
    @rooms = Room.order(:id)
    @user_bookings = current_user.bookings.where("(start_time > ?)", Time.now)
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_comment = RoomComment.new
    @bookings = current_user.bookings.where("(room_id = ? AND start_time > ?)", @room.id, Time.now)
  end

  def edit
    @room = Room.find_by_id(params[:id])
  end

  def update
    @room = Room.find_by_id(params[:id])
    @room.update_attributes(room_params)
    redirect_to room_path(@room)
  end

  private

  def room_params
    params.require(:room).permit(:name, :address, :capacity, :photo)
  end

  helper_method :current_room
  def current_room
    @current_room ||= Room.find_by_id(params[:id])
  end
end
