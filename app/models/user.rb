class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :banned, inclusion: { in: [true, false] }

  # ENUM mejora type-safety, rendimiento y elimina errores tipográficos
  enum role: { user: 'user', admin: 'admin' }, _default: 'user'

end
