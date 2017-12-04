class InterestedUser < ApplicationRecord
  before_save :figure_out_company
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness: true

  after_create :queue_thanks_email

  def queue_thanks_email
    InterestedUserWorker.perform_async(id)
  end

  def send_registered_interest_email
    InterestedUserMailer.user_registered(self).deliver
  end

  def figure_out_company
    self.company = self.email.split("@", 2).last.split(".", 2).first
  end
end
