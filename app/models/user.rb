class User < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :banned, inclusion: { in: [true, false] }
end
