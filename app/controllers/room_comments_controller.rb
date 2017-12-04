class RoomCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = current_account.rooms.find(params[:room_id])
    @room.room_comments.create(room_comment_params.merge(user: current_user))
    redirect_to room_path(@room)
  end

  private

  def room_comment_params
    params.require(:room_comment).permit(:category, :message)
  end
end
