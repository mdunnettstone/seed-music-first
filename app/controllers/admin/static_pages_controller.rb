class Admin::StaticPagesController < ApplicationController
  before_action :authenticate_user!, :authenticate_is_admin, :check_account_matches_user
  
  def dashboard
    @users = current_account.users.all
    @recent_bookings = current_account.bookings.where("(start_time > ? AND end_time < ?)", Time.now - 3.month, Time.now)
    @upcoming_bookings = current_account.bookings.where("(start_time > ?)", Time.now)
  end
end
