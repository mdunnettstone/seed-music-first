class BookingsController < ApplicationController
  def home

  end

  def index
    if params[:start_date] && params[:date]
      parsed_datetime = DateTime.parse("#{params[:start_date]} #{params[:date][:hour]}:#{params[:date][:minute]}")
    else
      parsed_datetime = DateTime.now
    end

    @duration_mins = (params[:duration] || 30).to_i
    @start_time    = rounded_datetime(parsed_datetime)

    search_start  = @start_time - 1.hour
    search_end    = @start_time + 1.hour + @duration_mins.minutes
    @rooms         = Room.all

    @bookings      = Booking.where("(end_time > ? AND end_time <= ?) OR (start_time < ? AND start_time >= ?)", search_start, search_end, search_end, search_start)

    #   | --------- --------------|

    # |===|        |=====|       |====|
      # 10  10:30 11:15 11:30   11:45 12:00
    @room_times    = build_room_times(@start_time - 1.hour, @start_time + 1.hour)
  end


  private

  def rounded_datetime(now)
    Time.local(now.year, now.month, now.day, now.hour, now.min/15*15)
  end

  def build_room_times(start_time, end_time)
    [start_time].tap { |array| array << array.last + 15.minutes while array.last < end_time }
  end
end


