class Admin::RoomCommentsController < ApplicationController
  def index
    @rooms = Room.order(:id)
  end
end
