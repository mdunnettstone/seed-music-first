class Admin::StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin
  
  def dashboard
    @users = current_account.users.all
    @recent_bookings = current_account.bookings.where("(start_time > ? AND end_time < ?)", Time.now - 3.month, Time.now)
    @upcoming_bookings = current_account.bookings.where("(start_time > ?)", Time.now)
  end
end
