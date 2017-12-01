class InterestedUser < ApplicationRecord
  before_save :make_postcode_nice
  before_save :figure_out_company_domain

  validates :postcode, presence: true
  validates :postcode, length: { minimum: 6 }
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness: true

  def make_postcode_nice
    new_postcode = self.postcode.gsub(/\s+/, "").upcase
    self.postcode = new_postcode[0..-4] + " " + new_postcode[-3..-1]
  end

  def figure_out_company_domain
    self.company = self.email.split("@", 2).last
  end
end
