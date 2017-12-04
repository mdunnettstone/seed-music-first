class Admin::RoomCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin
  
  def index
    @rooms = current_account.rooms.order(:id)
  end
end
