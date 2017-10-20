class Admin::StaticPagesController < ApplicationController
  def dashboard
    @users = User.all
    @recent_bookings = Booking.where("(start_time > ? AND end_time < ?)", Time.now - 3.month, Time.now)
    @upcoming_bookings = Booking.where("(start_time > ?)", Time.now)
  end
end
