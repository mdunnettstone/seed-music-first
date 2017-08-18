class User < ApplicationRecord
  has_many :user_instruments
  has_many :user_comments
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def unique_instruments
    instruments = []
    user_instruments.each do |ui|
      instruments << ui.instrument.name
    end
    instruments.uniq
  end

  # def uninstruments
  #   user_instruments.instruments.name.uniq
  # end

  def unique_genres
    genres = []
    user_instruments.each do |ui|
      genres << ui.genre.name
    end
    genres.uniq
  end
end
