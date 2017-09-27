class BookingsController < ApplicationController
  before_action :authenticate_user!
  def home

  end

  def new
    if params[:start_date] && params[:date]
      parsed_datetime = DateTime.parse("#{params[:start_date]} #{params[:date][:hour]}:#{params[:date][:minute]}")
    else
      parsed_datetime = rounded_datetime(DateTime.now) + 1.hour
    end
    @searched_start_time = rounded_datetime(parsed_datetime)

    
    search_start         = @searched_start_time - 1.hour
    search_end           = @searched_start_time + 1.hour
    @room_timeslots      = RoomTimeslot.order(:slot_start).where("(slot_end > ? AND slot_end <= ?) OR (slot_start < ? AND slot_start >= ?)", search_start, search_end, search_end, search_start)
    @rooms = Room.all
  end

  def create
    booking = Booking.create(booking_params)
    room_timeslots = RoomTimeslot.find(params[:room_timeslot_ids]).each{|timeslot| timeslot.update(booking: booking)}
    render json: { booking_info: "booked by #{booking.user.email}" }
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :user_id)
  end
  def rounded_datetime(t)
    Time.local(t.year, t.month, t.day, t.hour, t.min/15*15)
  end
end
