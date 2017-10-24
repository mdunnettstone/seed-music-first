class Admin::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_is_admin
  
  def index
    @future_bookings = Booking.where("(start_time > ?)", Time.now).sort_by{|booking| booking.start_time}
  end
end