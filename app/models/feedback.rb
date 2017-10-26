class Feedback < ApplicationRecord
  belongs_to :user, required: false
  validates :title, :message, presence: true
end
