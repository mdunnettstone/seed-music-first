class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
  end

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_comment = RoomComment.new
  end

  private

  def room_params
    params.require(:room).permit(:name, :address, :capacity)
  end

  helper_method :current_room
  def current_room
    @current_room ||= Room.find_by_id(params[:id])
  end
end
