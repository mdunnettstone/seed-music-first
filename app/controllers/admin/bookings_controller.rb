class Admin::BookingsController < ApplicationController
  before_action :authenticate_user!, :authenticate_is_admin, :check_account_matches_user
  
  def index
    @future_bookings = current_account.bookings.where("(start_time > ?)", Time.now).sort_by{|booking| booking.start_time}
  end
end
