class BookingMailer < ApplicationMailer
  default from: 'bookings@seedmusic.com'

  def booking_created
    mail(to: "mdunnettstone@gmail.com",
      subject: "A booking was created")
  end
end
