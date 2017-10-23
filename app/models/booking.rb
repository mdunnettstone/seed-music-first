class Booking < ApplicationRecord
  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings
  belongs_to :room
  after_create :send_booking_created_email
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
end
