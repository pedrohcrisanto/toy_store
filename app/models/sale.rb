# app/models/sale.rb
class Sale < ApplicationRecord
  belongs_to :client # Uma venda pertence a um cliente

  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
end
