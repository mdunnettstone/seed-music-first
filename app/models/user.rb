class User < ApplicationRecord
  has_many :user_instruments, inverse_of: :user, dependent: :destroy
  has_many :user_comments

  accepts_nested_attributes_for :user_instruments

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
