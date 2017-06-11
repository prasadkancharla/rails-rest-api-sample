class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :posts, foreign_key: :user
  # Validations
  validates_presence_of :name, :username, :password_digest
  validates :username, uniqueness: true
end
