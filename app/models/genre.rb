class Genre < ApplicationRecord
  has_many :user_instruments

  GENRES = {
    'jazz': 'jazz',
    'classical': 'classical',
    'pop': 'pop',
    'folk': 'folk',
    'rock': 'rock'
  }
end
