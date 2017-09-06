class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.search(search_params)
  end

  def show
    @user = User.find_by_id(params[:id])
  end
  
  private
  def search_params
    params.permit([:name, :instrument_id, :genre_id])
  end
end
