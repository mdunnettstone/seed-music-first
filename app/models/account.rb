class Account < ApplicationRecord
  has_many :bookings
  has_many :posts
  has_many :post_replies
  has_many :rooms
  has_many :room_comments
  has_many :room_facilities
  has_many :users
  has_many :user_bookings
  has_many :user_instruments
  has_many :whitelisted_emails
end
