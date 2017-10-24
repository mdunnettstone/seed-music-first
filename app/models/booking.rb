class Booking < ApplicationRecord
  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings
  belongs_to :room
  after_create :send_booking_created_email
  after_create :send_reminder
  before_destroy :send_booking_cancelled_email
  # belongs_to :room, through: :room_timelots

  def user_list
    usernames = []
    self.users.each do |user|
      usernames << "#{user.firstname} #{user.surname}"
    end
  usernames.join(", ")
  end

  def send_booking_created_email
    self.users.each do |user|
      BookingMailer.booking_created(self, user).deliver
    end 
  end

  def send_booking_cancelled_email
    self.users.each do |user|
      BookingMailer.booking_cancelled(self, user).deliver
    end
  end

  def send_reminder
    self.users.each do |user|
      BookingMailer.booking_reminder(self, user).deliver
    end
  end

  def when_to_send_reminder
    minutes_before_booking = 30.minutes
    start_time - minutes_before_booking
  end

  handle_asynchronously :send_reminder, :run_at => Proc.new { |i| i.when_to_send_reminder }
end
