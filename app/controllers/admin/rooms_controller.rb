class Admin::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin

  def new
    @room = Room.new
  end

  def create
    @room = current_account.rooms.create(room_params)
    redirect_to new_admin_room_room_facility_path(@room)
  end

  def edit
    @room = current_account.rooms.find_by_id(params[:id])
  end

  def update
    @room = current_account.rooms.find_by_id(params[:id])
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
