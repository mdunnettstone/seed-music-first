class BookingCreatedEmailWorker
  include Sidekiq::Worker

  def perform(id)
    booking = Booking.find(id)
    booking.send_booking_created_email
  end
end
