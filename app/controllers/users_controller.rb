class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = current_account.users.where.not(id: current_user.id).search(search_params)
    @recent_bookings = current_account.bookings.where("(start_time > ?)", Time.now - 6.month).order(:start_time)


    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = current_account.users.find_by_id(params[:id])
    @user_recent_bookings = @user.bookings.where("(start_time > ? AND start_time < ?)", Time.now - 6.month, Time.now)
    @user_future_bookings = @user.bookings.where("(start_time > ?)", Time.now)
    @posts = @user.posts
  end

  def check_email
    @user = current_account.users.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  private
  def search_params
    params.permit(:name, :genre_id => [], :instrument_id => [])
  end
end
