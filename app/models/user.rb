class User < ApplicationRecord
  belongs_to :account
  has_many :user_instruments, inverse_of: :user, dependent: :destroy
  has_many :user_comments
  has_many :user_bookings, dependent: :destroy
  has_many :bookings, through: :user_bookings
  has_many :posts
  has_many :post_replies
  has_many :feedbacks
  mount_uploader :avatar, AvatarUploader

  accepts_nested_attributes_for :user_instruments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # validate :email_is_whitelisted

  def self.search(params)
    search_scope = User.joins(:user_instruments)

    if params[:name].present?
      search_scope = search_scope.where("lower(CONCAT(firstname,' ',surname)) LIKE lower(?)", "%#{params[:name]}%")
    end

    if params[:instrument_id].present?
      params[:instrument_id].reject!{ |id| id.blank? }
      search_scope = search_scope.where(
        "user_instruments.instrument_id": params[:instrument_id]
      )
    end

    if params[:genre_id].present?
      # params[:genre_id].reject! { |id| id.blank? }
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

  def instrument_bracket_genres
    grouped_array = []
    user_instruments.all.group_by(&:instrument_id).each do |instrument_id, user_instruments|
      individual_array = []
      individual_array << Instrument.find(instrument_id).name
      genre_array = []
      user_instruments.each do |user_instrument|
        genre_array << Genre.find(user_instrument.genre_id).name
      end
      individual_array << genre_array
      grouped_array << individual_array
    end
    grouped_array
  end
  
  def fullname
    "#{self.firstname} #{self.surname}"
  end

  def email_is_whitelisted
    domain = email.split("@", 2).last
    if !WhitelistedEmail.where("email_or_domain = ? OR email_or_domain = ?", domain, email).exists?
      errors.add(:email, "Your email address has not been approved")
    end
  end
end
