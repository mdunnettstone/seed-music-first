class Instrument < ApplicationRecord
  has_many :user_instruments

  INSTRUMENTS = {
    'piano': 'piano',
    'violin': 'violin',
    'drums': 'drums',
    'saxophone': 'saxophone'
  }
end
