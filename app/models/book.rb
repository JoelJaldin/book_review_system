class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true

  MIN_REVIEWS_FOR_AVERAGE = 3
  INSUFFICIENT_REVIEWS = I18n.t("books.insufficient_reviews")

  def average_rating
    return INSUFFICIENT_REVIEWS unless has_enough_reviews?
    
    average = valid_reviews_for_rating.average(:rating)
    return INSUFFICIENT_REVIEWS if average.nil?

    average.round(1)
  end

  private

  def has_enough_reviews?
    valid_reviews_for_rating.count >= MIN_REVIEWS_FOR_AVERAGE
  end

  def valid_reviews_for_rating
    reviews.joins(:user).where(users: { banned: false })
  end
end
