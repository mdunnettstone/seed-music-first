class Admin::RoomCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin
  
  def index
    @rooms = Room.order(:id)
  end
end
