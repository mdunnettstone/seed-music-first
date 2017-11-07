class BookingsController < ApplicationController
  before_action :authenticate_user!
  def home
    @bookings = current_user.bookings.where("(start_time > ?)", Time.now).sort_by{|booking| booking.start_time}
    @prepopulated_search = rounded_datetime(Time.now)
    @genre = current_user.user_instruments.sample.genre
    @relevant_users = User.search(:genre_id => @genre.id).where.not(id: current_user.id)
  end

  def new
    if params[:start_date] && params[:date]
      parsed_datetime = DateTime.parse("#{params[:start_date]} #{params[:date][:hour]}:#{params[:date][:minute]}")
    else
      parsed_datetime = rounded_datetime(DateTime.now) + 1.hour
    end
    @searched_start_time = rounded_datetime(parsed_datetime)

    
    search_start         = @searched_start_time - 30.minute
    search_end           = @searched_start_time + 90.minute
    
    @timeslots           = build_room_times(search_start, search_end)
    @bookings            = Booking.where("(end_time > ? AND end_time <= ?) OR (start_time < ? AND start_time >= ?)", search_start, search_end, search_end, search_start)
    @rooms               = Room.order(:id)
    @users               = User.all
  end

  def create
    booking = Booking.new(booking_params)
    booking.users << current_user
    booking.assign_attributes(creator_user_id: current_user.id)
    if booking.save
      redirect_to booking_path(booking)
    else
      render json: {:errors => booking.errors.full_messages}, :status => :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find_by_id(params[:id])
    respond_to do |format|
      format.html {}
      
    end
  end

  def destroy
    @booking = Booking.find_by_id(params[:id])
    if @booking.users.any? {|user| user == current_user}
      @booking.destroy
      redirect_to root_path
    else
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  def edit
    @booking = Booking.find_by_id(params[:id])
    unless @booking.users.any? {|user| user == current_user}
      return render text: 'Not Allowed', status: :forbidden
    end
    @current_users = []
    @booking.users.each {|user| @current_users << user.id}
    @new_users = User.where.not(id: @current_users)
  end

  def add_user
    @booking = Booking.find_by_id(params[:id])
    unless @booking.users.any? {|user| user == current_user}
      return render text: 'Not Allowed', status: :forbidden
    end
    (params[:user_id]).each do |user_id|
      added_user = User.find(user_id)
      @booking.users << added_user
      BookingMailer.booking_user_added(@booking, added_user, current_user).deliver
    end
    redirect_to booking_path(@booking)
  end

  def remove_user
    @booking = Booking.find_by_id(params[:id])
    if current_user != @booking.creator
      if current_user.id == (params[:user_id]).to_i
        @booking.users.delete(User.find((params[:user_id]).to_i))
      else
        return render text: 'You may only remove yourself from the booking', status: :forbidden  
      end
    else
      return render text: 'As the creator of the booking, you may not remove yourself from the booking. Please cancel the booking and proceed from there', status: :forbidden
    end
    redirect_to home_path
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

  def rounded_datetime(t)
    Time.local(t.year, t.month, t.day, t.hour, t.min/15*15)
  end

  def build_room_times(start_time, end_time)
    [start_time].tap { |array| array << array.last + 15.minutes while array.last < end_time }
  end
end
