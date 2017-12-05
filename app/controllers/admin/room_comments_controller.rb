class Admin::RoomCommentsController < ApplicationController
  before_action :authenticate_user!, :authenticate_is_admin, :check_account_matches_user
  
  def index
    @rooms = current_account.rooms.order(:id)
  end
end
