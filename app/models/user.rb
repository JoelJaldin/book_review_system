class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :banned, inclusion: { in: [true, false] }
  validates :role, presence: true, inclusion: { in: ['user', 'admin'] }

  def admin?
    role == 'admin'
  end

  def regular_user?
    role == 'user'
  end
end
