# spec/factories/sales.rb
FactoryBot.define do
  factory :sale do
    association :client
    value { Faker::Commerce.price(range: 10.0..500.0) }
    sale_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
  end
end