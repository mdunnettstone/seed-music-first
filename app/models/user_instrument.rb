class UserInstrument < ApplicationRecord
  belongs_to :user
  belongs_to :instrument
  belongs_to :genre
end
