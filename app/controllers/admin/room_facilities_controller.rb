class Admin::RoomFacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin

  def new
    @room = Room.find_by_id(params[:room_id])
    @current_facilities = @room.facilities.all
    @room_facility = RoomFacility.new
  end

  def create
    @room_facility = current_room.room_facilities.create(room_facility_params)
    redirect_to room_path(current_room)
  end

  private

  def room_facility_params
    params.require(:room_facility).permit(:facility_id, :room_id)
  end

  helper_method :current_room
  def current_room
    @current_room ||= Room.find_by_id(params[:room_id])
  end
end
