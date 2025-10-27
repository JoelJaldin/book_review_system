class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true

  MIN_REVIEWS_FOR_AVERAGE = 3

  def average_rating
    valid_reviews = valid_reviews_for_rating
    
    return "Reseñas Insuficientes" if valid_reviews.count < MIN_REVIEWS_FOR_AVERAGE
    
    average = valid_reviews.average(:rating)
    return "Reseñas Insuficientes" if average.nil?
    
    average.round(1)
  end

  private

  def valid_reviews_for_rating
    reviews.joins(:user).where(users: { banned: false })
  end
end
