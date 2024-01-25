# spec/factories/locations.rb
FactoryBot.define do
  factory :location do
    name { 'Coffee Shop' }
    category { 'Cafe' }
    address { '123 Main St' }
    price { '$$' }
    rating { 4.5 }
  end
end
