class Booking < ApplicationRecord
  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings
  belongs_to :room
  belongs_to :account

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future
  validate :no_longer_than_2_hours_unless_admin
  validate :not_already_booked

  scope :within, ->(start_time, end_time) {
    where("(end_time > ? AND end_time <= ?) OR (start_time < ? AND start_time >= ?)", start_time, end_time, end_time, start_time)
  }

  after_create :queue_booking_created_email
  after_create :queue_booking_reminder_email
  before_destroy :send_booking_cancelled_email

  def user_list
    usernames = []
    self.users.each do |user|
      usernames << "#{user.firstname} #{user.surname}"
    end
  usernames.to_sentence
  end

  def creator
    User.find(creator_user_id)
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

  def no_longer_than_2_hours_unless_admin
    if (end_time - start_time) > 2.hour
      errors.add(:end_time, "You may only book for a maximum of 2 hours") unless users.last.admin
    end
  end

  def not_already_booked
    if overlapping_bookings.exists?
      errors.add(:room_id, "A booking already exists for this room")  
    end
  end

  def overlapping_bookings
    Booking.within(start_time, end_time).where(room: room)
  end

  def queue_booking_created_email
    BookingCreatedEmailWorker.perform_async(id)
  end

  def send_booking_created_email
    users.each do |user|
      BookingMailer.booking_created(self, user).deliver
    end 
  end

  def send_booking_cancelled_email
    users.each do |user|
      BookingMailer.booking_cancelled(self, user).deliver
    end
  end

  def queue_booking_reminder_email
    BookingReminderEmailWorker.perform_at(start_time - 30.minute, id)
  end

  def send_booking_reminder_email
    users.each do |user|
      BookingMailer.booking_reminder(self, user).deliver
    end
  end

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end
end
