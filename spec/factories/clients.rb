# spec/factories/clients.rb
FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end