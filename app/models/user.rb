# app/models/user.rb

class User < ApplicationRecord
  # Inclua os módulos Devise que você precisa
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: ::Devise::JWT::RevocationStrategies::Denylist

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create


end