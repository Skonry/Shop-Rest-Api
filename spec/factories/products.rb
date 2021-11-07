FactoryBot.define do
  factory :product do
    name: { "Harry Potter" }
    price: 30.0
    
    association :category
  end
end