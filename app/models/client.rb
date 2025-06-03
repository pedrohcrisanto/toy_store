# app/models/client.rb
class Client < ApplicationRecord
  per_page = 10.freeze

  has_many :sales, dependent: :destroy # Um cliente pode ter muitas vendas

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
end
