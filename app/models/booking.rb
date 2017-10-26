class Booking < ApplicationRecord
  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings
  belongs_to :room

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future
  # validate :no_longer_than_2_hours_unless_admin
  # validate :not_already_booked


  after_create :send_booking_created_email
  after_create :send_reminder
  before_destroy :send_booking_cancelled_email

  def user_list
    usernames = []
    self.users.each do |user|
      usernames << "#{user.firstname} #{user.surname}"
    end
  usernames.join(", ")
  end

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def start_time_in_future
    if start_time < Time.now
      errors.add(:start_time, "booking must be in the future")
    end
  end

  # def no_longer_than_2_hours_unless_admin
  #   unless users.first.admin
  #     if (end_time - start_time) > 2.hour
  #       errors.add(:end_time, "You may only book for a maximum of 2 hours")
  #     end
  #   end
  # end

  # def not_already_booked

  # end

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
