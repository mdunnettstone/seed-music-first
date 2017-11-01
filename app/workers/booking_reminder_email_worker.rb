class BookingReminderEmailWorker
  include Sidekiq::Worker

  def perform(id)
    booking = Booking.find(id)
    booking.send_booking_reminder_email
  end
end
