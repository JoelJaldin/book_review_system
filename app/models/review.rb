class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :reviewer_name, presence: true, length: { maximum: 100 }
end
