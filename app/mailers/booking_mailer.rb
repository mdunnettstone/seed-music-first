class BookingMailer < ApplicationMailer
  default from: 'mdunnettstone@gmail.com'

  def booking_created(booking, user)
    @booking    = booking
    @recipient  = user.email
    @date       = booking.start_time.strftime("%a, %e %b %Y")
    @start_time = booking.start_time.strftime("%H:%M")
    @end_time   = booking.end_time.strftime("%H:%M")
    @room_name  = booking.room.name
    mail(to: @recipient,
      subject: "Booking confirmed for #{@date}")
  end

  def booking_cancelled(booking, user)
    @booking    = booking
    @recipient  = user.email
    @date       = booking.start_time.strftime("%a, %e %b %Y")
    @start_time = booking.start_time.strftime("%H:%M")
    @end_time   = booking.end_time.strftime("%H:%M")
    @room_name  = booking.room.name
    mail(to: @recipient,
      subject: "Booking cancelled :(")
  end
end
