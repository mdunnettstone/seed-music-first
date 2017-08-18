class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find_by_id(params[:id])
    @room_comment = RoomComment.new
  end
end
