class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true

  MIN_REVIEWS_FOR_AVERAGE = 3

  # Scopes de Review
  def average_rating
    return insufficient_reviews_message unless has_sufficient_reviews?

    average = valid_reviews.average(:rating)
    return insufficient_reviews_message if average.nil?

    average.round(1)
  end

  def has_sufficient_reviews?
    valid_reviews.count >= MIN_REVIEWS_FOR_AVERAGE
  end

  # Scope de Review
  def valid_reviews
    reviews.from_active_users
  end

  private

  # Refactorización: I18n se llama en el método, no como constante de clase
  def insufficient_reviews_message
    I18n.t("books.insufficient_reviews")
  end
end
