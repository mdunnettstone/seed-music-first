class Post < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :title, presence: true
  validates :message, length: { minimum: 3 }

  CATEGORIES = {
    'Bands --> Musicians': 'Bandseek',
    'Musicians --> Bands': 'Musicianseek',
    'Events': 'Event',
    'Music recommendations': 'Music'
  }

  def humanized_category
    CATEGORIES.invert[self.category]
  end

  def self.search(params)
    search_scope = Post.all

    if params[:text].present?
      search_scope = search_scope.where("lower(message) LIKE lower(?)", "%#{params[:text]}%")
    end

    if params[:categories].present?
      search_scope = search_scope.where("category": params[:categories])
    end

    search_scope.distinct.order(:created_at)
  end
end
