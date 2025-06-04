# app/models/sale.rb
class Sale < ApplicationRecord
  belongs_to :client

  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
  validate :sale_date_cannot_be_in_the_future

  private

  def sale_date_cannot_be_in_the_future
    if sale_date.present? && sale_date > Date.today
      errors.add(:sale_date, "cannot be in the future")
    end
  end
end
