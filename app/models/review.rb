class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :reviewer_name, presence: true, length: { maximum: 100 }

  # Scopes:
  scope :from_active_users, -> { joins(:user).where(users: { banned: false }) }
  scope :ordered_by_created, -> { order(created_at: :desc) }
  scope :with_users, -> { includes(:user) }

  # Callback: setea automáticamente el reviewer_name desde el usuario al crear
  before_validation :set_reviewer_name, on: :create

  # Refactorización: lógica movida desde el controlador al modelo, construye review con usuario asignado automáticamente
  def self.build_for_user(book, user, params)
    review = book.reviews.build(params)
    review.user = user
    review.reviewer_name ||= user.name
    review
  end

  private

  def set_reviewer_name
    self.reviewer_name ||= user&.name
  end
end
