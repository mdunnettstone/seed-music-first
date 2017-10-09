class User < ApplicationRecord
  has_many :user_instruments, inverse_of: :user, dependent: :destroy
  has_many :user_comments
  has_many :user_bookings, dependent: :destroy
  has_many :bookings, through: :user_bookings
  mount_uploader :avatar, AvatarUploader

  accepts_nested_attributes_for :user_instruments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.search(params)
    search_scope = User.joins(:user_instruments)

    if params[:name].present?
      search_scope = search_scope.where("CONCAT(firstname,' ',surname) LIKE ?", "%#{params[:name]}%")
    end

    if params[:instrument_id].present?
      params[:instrument_id].reject! { |id| id.blank? }
      search_scope = search_scope.where(
        "user_instruments.instrument_id": params[:instrument_id]
      )
    end

    if params[:genre_id].present?
      params[:genre_id].reject! { |id| id.blank? }
      search_scope = search_scope.where(
        "user_instruments.genre_id": params[:genre_id]
      )
    end

    search_scope.distinct.order(:created_at)
  end

  def unique_instruments
    instruments = []
    user_instruments.each do |ui|
      instruments << ui.instrument.name
    end
    instruments.uniq
  end

  def unique_genres
    genres = []
    user_instruments.each do |ui|
      genres << ui.genre.name
    end
    genres.uniq
  end

  def fullname
    "#{self.firstname} #{self.surname}"
  end

  ## LAME ATTEMPT AT BEING ABLE TO CALL user.avatar REGARDLESS OF ITS PRESENCE
  # def profile_pic
  #   if avatar.present?
  #   else
  #     avatar = image_url('placeholder-user-profile.png')
  #   end
  #   return avatar
  # end
end
