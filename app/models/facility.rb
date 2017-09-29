class Facility < ApplicationRecord
  has_many :room_facilities
  has_many :rooms, through: :room_facilities

  def full_facility
    "#{self.instrument}: #{self.brand}, #{self.model}"
  end
end
