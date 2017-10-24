class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.search(search_params)
    @recent_bookings = Booking.where("(start_time > ?)", Time.now - 6.month).order(:start_time)


    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @user_recent_bookings = @user.bookings.where("(start_time > ? AND start_time < ?)", Time.now - 6.month, Time.now)
    @user_future_bookings = @user.bookings.where("(start_time > ?)", Time.now)
    @posts = @user.posts
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  private
  def search_params
    params.permit(:name, :genre_id => [], :instrument_id => [])
  end
end
